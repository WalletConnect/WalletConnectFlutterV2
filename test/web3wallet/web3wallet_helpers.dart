import 'dart:async';
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../auth_api/utils/engine_constants.dart';
import '../auth_api/utils/signature_constants.dart';
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

class Web3WalletHelpers {
  static Future<TestConnectMethodReturn> testWeb3Wallet(
    IWeb3App a,
    IWeb3Wallet b, {
    Map<String, Namespace>? namespaces,
    Map<String, RequiredNamespace>? requiredNamespaces,
    List<Relay>? relays,
    String? pairingTopic,
    int? qrCodeScanLatencyMs,
    bool testFailure = false,
  }) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    final Map<String, RequiredNamespace> reqNamespaces =
        requiredNamespaces ?? TEST_REQUIRED_NAMESPACES;

    Map<String, Namespace> workingNamespaces = namespaces ?? TEST_NAMESPACES;

    SessionData? sessionA;
    SessionData? sessionB;
    AuthResponse? authResponse;

    // Listen for a proposal via connect to avoid race conditions
    Completer signCompleter = Completer();
    signHandler(SessionProposalEvent? args) async {
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
      signCompleter.complete();
      // if (sessionB == null) {
      //   print('session b was set to null');
      // }
    }

    b.onSessionProposal.subscribe(signHandler);

    // Listen for a auth request
    Completer authCompleter = Completer();
    authHandler(AuthRequest? args) async {
      // print('B Auth Request');

      expect(b.getPendingAuthRequests().length, 1);

      // Create the message to be signed
      String message = b.authEngine.formatAuthMessage(
        iss: TEST_ISSUER_EIP191,
        cacaoPayload: CacaoRequestPayload.fromPayloadParams(
          args!.payloadParams,
        ),
      );

      String sig = EthSigUtil.signPersonalMessage(
        message: Uint8List.fromList(message.codeUnits),
        privateKey: TEST_PRIVATE_KEY_EIP191,
      );

      await b.respondAuthRequest(
        id: args.id,
        iss: TEST_ISSUER_EIP191,
        signature: CacaoSignature(t: CacaoSignature.EIP191, s: sig),
      );
      authCompleter.complete();
    }

    b.onAuthRequest.subscribe(authHandler);

    // Connect to client b from a, this will trigger the above event
    // print('connecting');
    ConnectResponse connectResponse = await a.connect(
      requiredNamespaces: reqNamespaces,
      pairingTopic: pairingTopic,
      relays: relays,
    );
    Uri? uri = connectResponse.uri;

    // Send an auth request as well
    // print('requesting auth');
    AuthRequestResponse authReqResponse = await a.requestAuth(
      params: testAuthRequestParamsValid,
      pairingTopic: connectResponse.pairingTopic,
    );
    expect(connectResponse.pairingTopic, authReqResponse.pairingTopic);
    expect(authReqResponse.uri, null);

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
      expect(pairingA.relay.protocol, uriParams.v2Data!.relay.protocol);

      // If we recieved no pairing topic, then we want to create one
      // e.g. we pair from b to a using the uri created from the connect
      // params (The QR code).
      const pairTimeoutMs = 15000;
      final timeout = Timer(const Duration(milliseconds: pairTimeoutMs), () {
        throw Exception('Pair timed out after $pairTimeoutMs ms');
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
    // print(
    //     'Waiting for auth response: ${authReqResponse.completer.isCompleted}');
    authResponse = await authReqResponse.completer.future;

    final settlePairingLatencyMs = DateTime.now().millisecondsSinceEpoch -
        start -
        (qrCodeScanLatencyMs ?? 0);

    // print('here 1');
    await signCompleter.future;
    // print('here 2');
    await authCompleter.future;

    // if (sessionA == null) throw Exception("expect session A to be defined");
    if (sessionB == null) throw Exception('expect session B to be defined');

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

    // if (authResponse == null)
    //   throw Exception("expect authResponse to be defined");

    expect(authResponse.result != null, true);
    expect(authResponse.error == null, true);
    expect(authResponse.jsonRpcError == null, true);

    // if (pairingA == null) throw Exception("expect pairing A to be defined");
    if (pairingB == null) throw Exception('expect pairing B to be defined');

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

    b.onSessionProposal.unsubscribe(signHandler);
    b.onAuthRequest.unsubscribe(authHandler);

    return TestConnectMethodReturn(
      pairingA,
      sessionA,
      clientAConnectLatencyMs,
      settlePairingLatencyMs,
    );
  }
}
