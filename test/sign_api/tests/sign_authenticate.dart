import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';

void signAuthenticate({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('happy path', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER.copyWith(
        redirect: Redirect(
          native: 'clientA://',
          universal: 'https://lab.web3modal.com/dapp',
          linkMode: true,
        ),
      ));
      clientB = await clientBCreator(RESPONDER.copyWith(
        redirect: Redirect(
          native: 'clientB://',
          universal: 'https://lab.web3modal.com/wallet',
          linkMode: true,
        ),
      ));
      clients.add(clientA);
      clients.add(clientB);
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('Initializes', () async {
      expect(clientA.core.pairing.getPairings().length, 0);
      expect(clientB.core.pairing.getPairings().length, 0);
    });

    test('creates correct URI for LinkMode', () async {
      await clientA.core.addLinkModeSupportedApp(
        'https://lab.web3modal.com/wallet',
      );
      await clientB.core.addLinkModeSupportedApp(
        'https://lab.web3modal.com/dapp',
      );

      SessionAuthRequestResponse response = await clientA.authenticate(
        params: SessionAuthRequestParams(
          chains: ['eip155:1'],
          domain: 'lab.web3modal.com',
          nonce: 'XpJ0thNvq9lNixmwN',
          uri: 'https://lab.web3modal.com/dapp',
          statement: 'Connect to Web3Modal Lab',
          methods: ['personal_sign'],
        ),
        walletUniversalLink: 'https://lab.web3modal.com/wallet',
      );

      expect(response.uri != null, true);
      final envelope = WalletConnectUtils.getSearchParamFromURL(
        '${response.uri}',
        'wc_ev',
      );
      final message = Uri.decodeComponent(envelope);

      final topic = WalletConnectUtils.getSearchParamFromURL(
        '${response.uri}',
        'topic',
      );
      expect(message.isNotEmpty, true);
      expect(topic.isNotEmpty, true);
      expect(topic, response.pairingTopic);

      // Decode the message
      String? payloadString = await clientA.core.crypto.decode(
        topic,
        message,
      );
      expect(payloadString, isNotNull);

      Map<String, dynamic> data = jsonDecode(payloadString!);

      expect(data.containsKey('method'), true);

      final request = JsonRpcRequest.fromJson(data);

      expect(request.method, MethodConstants.WC_SESSION_AUTHENTICATE);
    });
  });
}
