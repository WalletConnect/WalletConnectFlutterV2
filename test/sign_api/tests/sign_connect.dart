import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/engine_constants.dart';
import '../utils/sign_client_constants.dart';

void signConnect({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('happy path', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
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

    test('creates correct URI', () async {
      ConnectResponse response = await clientA.connect(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
      );

      expect(response.uri != null, true);
      URIParseResult parsed = WalletConnectUtils.parseUri(response.uri!);
      expect(parsed.protocol, 'wc');
      expect(parsed.version, '2');
      expect(parsed.topic, response.pairingTopic);
      expect(parsed.relay.protocol, 'irn');
      if (clientA is IWeb3App) {
        expect(parsed.methods.length, 3);
        expect(parsed.methods[0], MethodConstants.WC_SESSION_PROPOSE);
        expect(parsed.methods[1], MethodConstants.WC_SESSION_REQUEST);
        expect(parsed.methods[2], MethodConstants.WC_AUTH_REQUEST);
      } else {
        expect(parsed.methods.length, 2);
        expect(parsed.methods[0], MethodConstants.WC_SESSION_PROPOSE);
        expect(parsed.methods[1], MethodConstants.WC_SESSION_REQUEST);
      }

      response = await clientA.connect(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        methods: [],
      );

      expect(response.uri != null, true);
      parsed = WalletConnectUtils.parseUri(response.uri!);
      expect(parsed.protocol, 'wc');
      expect(parsed.version, '2');
      expect(parsed.relay.protocol, 'irn');
      expect(parsed.methods.length, 0);
    });

    test('invalid topic', () {
      expect(
        () async => await clientA.connect(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          pairingTopic: TEST_TOPIC_INVALID,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'No matching key. pairing topic doesn\'t exist: abc',
          ),
        ),
      );
    });

    test('invalid required and optional namespaces', () {
      expect(
        () async => await clientA.connect(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. connect() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
          ),
        ),
      );
      expect(
        () async => await clientA.connect(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          optionalNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. connect() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
          ),
        ),
      );
    });
  });
}
