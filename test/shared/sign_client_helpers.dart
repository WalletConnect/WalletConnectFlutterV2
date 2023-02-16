import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../sign_api/utils/sign_client_constants.dart';

class TestConnectMethodReturn {
  PairingInfo pairing;
  SessionData session;
  int connectLatency;
  int settleLatency;

  TestConnectMethodReturn(
    this.pairing,
    this.session,
    this.connectLatency,
    this.settleLatency,
  );
}

class SignClientHelpers {
  static Future<TestConnectMethodReturn> testConnectPairApprove(
    ISignEngineApp a,
    ISignEngineWallet b, {
    Map<String, Namespace>? namespaces,
    Map<String, RequiredNamespace>? requiredNamespaces,
    List<Relay>? relays,
    String? pairingTopic,
    int? qrCodeScanLatencyMs,
    bool testFailure = false,
  }) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    final Map<String, RequiredNamespace> reqNamespaces =
        requiredNamespaces != null
            ? requiredNamespaces
            : TEST_REQUIRED_NAMESPACES;

    Map<String, Namespace> workingNamespaces =
        namespaces != null ? namespaces : TEST_NAMESPACES;

    SessionData? sessionA;
    SessionData? sessionB;

    // Listen for a proposal via connect to avoid race conditions
    final f = (SessionProposalEvent? args) async {
      // print('B Session Proposal');

      expect(
        args!.params.requiredNamespaces,
        reqNamespaces,
      );

      expect(b.getPendingSessionProposals().length, 1);

      ApproveResponse response = await b.approveSession(
        id: args.id,
        namespaces: workingNamespaces,
      );
      sessionB = response.session;
      if (sessionB == null) {
        print('session b was set to null');
      }

      // print('B Session assigned: $sessionB');
      // expect(b.core.expirer.has(args.params.id.toString()), true);
    };
    b.onSessionProposal.subscribe(f);

    // Connect to client b from a, this will trigger the above event
    // print('connecting');
    ConnectResponse connectResponse = await a.connect(
      requiredNamespaces: reqNamespaces,
      pairingTopic: pairingTopic,
      relays: relays,
    );
    Uri? uri = connectResponse.uri;

    // Track latency
    final clientAConnectLatencyMs =
        DateTime.now().millisecondsSinceEpoch - start;

    // Track pairings from "QR Scans"
    PairingInfo? pairingA;
    PairingInfo? pairingB;

    if (pairingTopic == null) {
      // Simulate qr code scan latency if we want
      if (uri == null) {
        throw Exception('uri is missing');
      }
      if (qrCodeScanLatencyMs != null) {
        await Future.delayed(
          Duration(
            milliseconds: qrCodeScanLatencyMs,
          ),
        );
      }

      final uriParams = WalletConnectUtils.parseUri(connectResponse.uri!);
      pairingA = a.pairings.get(uriParams.topic);
      expect(pairingA != null, true);
      expect(pairingA!.topic, uriParams.topic);
      expect(pairingA.relay.protocol, uriParams.relay.protocol);

      // If we recieved no pairing topic, then we want to create one
      // e.g. we pair from b to a using the uri created from the connect
      // params (The QR code).
      final pairTimeoutMs = 15000;
      final timeout = Timer(Duration(milliseconds: pairTimeoutMs), () {
        throw Exception("Pair timed out after $pairTimeoutMs ms");
      });
      // print('pairing B -> A');
      pairingB = await b.pair(uri: uri);
      timeout.cancel();
      expect(pairingA.topic, pairingB.topic);
      expect(pairingA.relay.protocol, pairingB.relay.protocol);
    } else {
      pairingA = a.pairings.get(pairingTopic);
      pairingB = b.pairings.get(pairingTopic);
    }

    if (pairingA == null) {
      throw Exception('expect pairing A to be defined');
    }

    // Assign session now that we have paired
    // print('Waiting for connect response');
    sessionA = await connectResponse.session.future;

    final settlePairingLatencyMs = DateTime.now().millisecondsSinceEpoch -
        start -
        (qrCodeScanLatencyMs ?? 0);

    await Future.delayed(Duration(milliseconds: 200));

    if (sessionB == null) print(sessionB);
    if (sessionA == null) throw Exception("expect session A to be defined");
    if (sessionB == null) throw Exception("expect session B to be defined");

    expect(sessionA.topic, sessionB!.topic);
    // relay
    expect(
      sessionA.relay.protocol,
      TEST_RELAY_OPTIONS['protocol'],
    );
    expect(sessionA.relay.protocol, sessionB!.relay.protocol);
    // namespaces
    expect(sessionA.namespaces, workingNamespaces);
    expect(sessionA.namespaces, sessionB!.namespaces);
    // expiry
    expect((sessionA.expiry - sessionB!.expiry).abs() < 5, true);
    // Check that there is an expiry
    expect(a.core.expirer.has(sessionA.topic), true);
    expect(b.core.expirer.has(sessionB!.topic), true);
    // acknowledged
    expect(sessionA.acknowledged, sessionB!.acknowledged);
    // participants
    expect(sessionA.self, sessionB!.peer);
    expect(sessionA.peer, sessionB!.self);
    // controller

    expect(sessionA.controller, sessionB!.controller);
    expect(sessionA.controller, sessionA.peer.publicKey);
    expect(sessionB!.controller, sessionB!.self.publicKey);
    // metadata
    expect(sessionA.self.metadata, sessionB!.peer.metadata);
    expect(sessionB!.self.metadata, sessionA.peer.metadata);

    // if (pairingA == null) throw Exception("expect pairing A to be defined");
    if (pairingB == null) throw Exception("expect pairing B to be defined");

    // update pairing state beforehand
    pairingA = a.pairings.get(pairingA.topic);
    pairingB = b.pairings.get(pairingB.topic);

    // topic
    expect(pairingA!.topic, pairingB!.topic);
    // relay
    expect(
      pairingA.relay.protocol,
      TEST_RELAY_OPTIONS['protocol'],
    );
    expect(
      pairingB.relay.protocol,
      TEST_RELAY_OPTIONS['protocol'],
    );
    // active
    expect(pairingA.active, true);
    expect(pairingB.active, true);
    // metadata
    expect(
      pairingA.peerMetadata,
      sessionA.peer.metadata,
    );
    expect(
      pairingB.peerMetadata,
      sessionB!.peer.metadata,
    );

    b.onSessionProposal.unsubscribe(f);

    return TestConnectMethodReturn(
      pairingA,
      sessionA,
      clientAConnectLatencyMs,
      settlePairingLatencyMs,
    );
  }
}
