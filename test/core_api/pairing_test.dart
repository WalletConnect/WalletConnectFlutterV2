import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/core/core.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/uri_parse_result.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/method_constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );

  test('Format and parses URI correctly', () {
    Uri response = WalletConnectUtils.formatUri(
        protocol: 'wc',
        version: '2',
        topic: 'abc',
        symKey: 'xyz',
        relay: Relay('irn'),
        methods: [
          [MethodConstants.WC_SESSION_PROPOSE],
          [MethodConstants.WC_AUTH_REQUEST, 'wc_authBatchRequest'],
        ]);
    expect(
      Uri.decodeFull(response.toString()),
      'wc:abc@2?relay-protocol=irn&symKey=xyz&methods=[wc_sessionPropose],[wc_authRequest,wc_authBatchRequest]',
    );

    URIParseResult parsed = WalletConnectUtils.parseUri(response);
    expect(parsed.protocol, 'wc');
    expect(parsed.version, URIVersion.v2);
    expect(parsed.topic, 'abc');
    expect(parsed.v2Data!.symKey, 'xyz');
    expect(parsed.v2Data!.relay.protocol, 'irn');
    expect(parsed.v2Data!.methods.length, 3);
    expect(parsed.v2Data!.methods[0], MethodConstants.WC_SESSION_PROPOSE);
    expect(parsed.v2Data!.methods[1], MethodConstants.WC_AUTH_REQUEST);
    expect(parsed.v2Data!.methods[2], 'wc_authBatchRequest');

    response = WalletConnectUtils.formatUri(
      protocol: 'wc',
      version: '2',
      topic: 'abc',
      symKey: 'xyz',
      relay: Relay('irn'),
      methods: null,
    );
    expect(
      Uri.decodeFull(response.toString()),
      'wc:abc@2?relay-protocol=irn&symKey=xyz&methods=[]',
    );

    parsed = WalletConnectUtils.parseUri(response);
    expect(parsed.protocol, 'wc');
    expect(parsed.version, URIVersion.v2);
    expect(parsed.topic, 'abc');
    expect(parsed.v2Data!.symKey, 'xyz');
    expect(parsed.v2Data!.relay.protocol, 'irn');
    expect(parsed.v2Data!.methods.length, 0);

    // Can parse URI with missing methods param
    response = Uri.parse('wc:abc@2?relay-protocol=irn&symKey=xyz');
    expect(parsed.protocol, 'wc');
    expect(parsed.version, URIVersion.v2);
    expect(parsed.topic, 'abc');
    expect(parsed.v2Data!.symKey, 'xyz');
    expect(parsed.v2Data!.relay.protocol, 'irn');
    expect(parsed.v2Data!.methods.length, 0);

    // V1 testing
    parsed = WalletConnectUtils.parseUri(Uri.parse(
        'wc:00e46b69-d0cc-4b3e-b6a2-cee442f97188@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae'));
    expect(parsed.protocol, 'wc');
    expect(parsed.version, URIVersion.v1);
    expect(parsed.topic, '00e46b69-d0cc-4b3e-b6a2-cee442f97188');
    expect(parsed.v2Data, null);
    expect(parsed.v1Data!.key,
        '91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae');
    expect(parsed.v1Data!.bridge, 'https://bridge.walletconnect.org');
  });

  group('history', () {
    test('deletes old records', () async {});
  });

  group('Pairing API', () {
    late ICore coreA;
    late ICore coreB;

    setUp(() async {
      coreA = Core(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      coreB = Core(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      await coreA.start();
      await coreB.start();
    });

    tearDown(() async {
      await coreA.relayClient.disconnect();
      await coreB.relayClient.disconnect();
    });

    test('Initializes', () async {
      expect(coreA.pairing.getPairings().length, 0);
      expect(coreB.pairing.getPairings().length, 0);
    });

    group('create', () {
      test('returns pairing topic and URI in expected format', () async {
        Completer completer = Completer();
        int counter = 0;
        coreA.pairing.onPairingCreate.subscribe((args) {
          counter++;
          completer.complete();
        });

        CreateResponse response = await coreA.pairing.create();
        await completer.future;
        expect(response.topic.length, 64);
        // print(response.uri);
        // print('${coreA.protocol}:${response.topic}@${coreA.version}');
        expect(
          response.uri.toString().startsWith(
                '${coreA.protocol}:${response.topic}@${coreA.version}',
              ),
          true,
        );
        expect(counter, 1);

        response = await coreB.pairing.create(methods: [
          [MethodConstants.WC_SESSION_PROPOSE],
          [MethodConstants.WC_AUTH_REQUEST, 'wc_authBatchRequest'],
        ]);

        final URIParseResult parsed = WalletConnectUtils.parseUri(response.uri);
        expect(parsed.protocol, 'wc');
        expect(parsed.version, URIVersion.v2);
        expect(parsed.v2Data!.relay.protocol, 'irn');
        expect(parsed.v2Data!.methods.length, 3);
        expect(parsed.v2Data!.methods[0], MethodConstants.WC_SESSION_PROPOSE);
        expect(parsed.v2Data!.methods[1], MethodConstants.WC_AUTH_REQUEST);
        expect(parsed.v2Data!.methods[2], 'wc_authBatchRequest');
      });
    });

    group('pair', () {
      test('can pair via provided URI', () async {
        final CreateResponse response = await coreA.pairing.create();

        Completer completer = Completer();
        int counter = 0;
        coreB.pairing.onPairingCreate.subscribe((args) {
          counter++;
          completer.complete();
        });

        await coreB.pairing.pair(uri: response.uri, activatePairing: false);
        await completer.future;

        expect(counter, 1);

        expect(coreA.pairing.getPairings().length, 1);
        expect(coreB.pairing.getPairings().length, 1);
        expect(
          coreA.pairing.getPairings()[0].topic,
          coreB.pairing.getPairings()[0].topic,
        );
        expect(coreA.pairing.getPairings()[0].active, false);
        expect(coreB.pairing.getPairings()[0].active, false);
      });

      test('can pair via provided URI', () async {
        final CreateResponse response = await coreA.pairing.create();

        await coreB.pairing.pair(uri: response.uri, activatePairing: true);
        expect(coreA.pairing.getPairings()[0].active, false);
        expect(coreB.pairing.getPairings()[0].active, true);
      });
    });

    test('can activate pairing', () async {
      final CreateResponse response = await coreA.pairing.create();

      await coreB.pairing.pair(uri: response.uri, activatePairing: false);
      PairingInfo? pairing = coreB.pairing.getStore().get(response.topic);

      expect(pairing != null, true);
      expect(pairing!.active, false);
      final int expiry = pairing.expiry;
      await coreB.pairing.activate(topic: response.topic);
      PairingInfo? pairing2 = coreB.pairing.getStore().get(response.topic);
      expect(pairing2 != null, true);
      expect(pairing2!.active, true);
      expect(pairing2.expiry > expiry, true);
    });

    test('can update expiry', () async {
      final CreateResponse response = await coreA.pairing.create();
      const int mockExpiry = 1111111;

      await coreA.pairing
          .updateExpiry(topic: response.topic, expiry: mockExpiry);
      expect(coreA.pairing.getStore().get(response.topic)!.expiry, mockExpiry);
      expect(coreA.expirer.get(response.topic), mockExpiry);
    });

    test('update expiry throws error if expiry past 30 days', () async {
      final CreateResponse response = await coreA.pairing.create();
      final int mockExpiry = WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.THIRTY_DAYS + 1,
      );

      expect(
        () async => await coreA.pairing.updateExpiry(
          topic: response.topic,
          expiry: mockExpiry,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Expiry cannot be more than 30 days away',
          ),
        ),
      );
    });

    test('can update peer metadata', () async {
      final CreateResponse response = await coreA.pairing.create();
      PairingMetadata mock = const PairingMetadata(
        name: 'Mock',
        description: 'Mock Metadata',
        url: 'https://mockurl.com',
        icons: [],
      );

      expect(
        coreA.pairing.getStore().get(response.topic)!.peerMetadata == null,
        true,
      );
      coreA.pairing.updateMetadata(topic: response.topic, metadata: mock);
      expect(
        coreA.pairing.getStore().get(response.topic)!.peerMetadata!.name,
        mock.name,
      );
    });

    test('clients can ping each other', () async {
      final CreateResponse response = await coreA.pairing.create();
      // await coreB.pairing.pair(uri: response.uri);

      Completer completer = Completer();
      coreB.pairing.onPairingPing.subscribe((args) {
        expect(args != null, true);
        completer.complete();
      });

      await coreB.pairing.pair(uri: response.uri, activatePairing: true);
      await coreA.pairing.activate(topic: response.topic);
      await coreA.pairing.ping(topic: response.topic);

      await completer.future;
    });

    test('can disconnect from a known pairing', () async {
      final CreateResponse response = await coreA.pairing.create();
      expect(coreA.pairing.getStore().getAll().length, 1);
      expect(coreB.pairing.getStore().getAll().length, 0);
      await coreB.pairing.pair(uri: response.uri, activatePairing: true);
      expect(coreA.pairing.getStore().getAll().length, 1);
      expect(coreB.pairing.getStore().getAll().length, 1);
      bool hasDeletedA = false;
      bool hasDeletedB = false;

      Completer completerA = Completer();
      Completer completerB = Completer();
      coreA.pairing.onPairingDelete.subscribe((args) {
        expect(args != null, true);
        expect(args!.topic != null, true);
        expect(args.error == null, true);
        hasDeletedA = true;
        completerA.complete();
      });
      coreB.pairing.onPairingDelete.subscribe((args) {
        expect(args != null, true);
        expect(args!.topic != null, true);
        expect(args.error == null, true);
        hasDeletedB = true;
        completerB.complete();
      });

      await coreB.pairing.disconnect(topic: response.topic);

      await completerA.future;
      await completerB.future;

      expect(hasDeletedA, true);
      expect(hasDeletedB, true);
      expect(coreA.pairing.getStore().getAll().length, 0);
      expect(coreB.pairing.getStore().getAll().length, 0);
    });

    group('Validations', () {
      setUp(() async {
        coreA = Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
          httpClient: getHttpWrapper(),
        );
        await coreA.start();
      });

      tearDown(() async {
        await coreA.relayClient.disconnect();
      });

      group('Pairing', () {
        test('throws when no empty/invalid uri is provided', () async {
          expect(
            () async => await coreA.pairing.pair(uri: Uri.parse('')),
            throwsA(
              predicate(
                (e) =>
                    e is WalletConnectError &&
                    e.message == 'Invalid URI: Missing @',
              ),
            ),
          );
          expect(
            () async => await coreA.pairing.pair(uri: Uri.parse('wc:abc')),
            throwsA(
              predicate(
                (e) =>
                    e is WalletConnectError &&
                    e.message == 'Invalid URI: Missing @',
              ),
            ),
          );
        });

        test("throws when required methods aren't contained in registered",
            () async {
          const String uriWithMethods =
              '$TEST_URI&methods=[wc_sessionPropose],[wc_authRequest,wc_authBatchRequest]';
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is WalletConnectError &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_sessionPropose, wc_authRequest, wc_authBatchRequest.',
              ),
            ),
          );
          coreA.pairing.register(
            method: 'wc_sessionPropose',
            function: (s, r) => {},
            type: ProtocolType.sign,
          );
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is WalletConnectError &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_authRequest, wc_authBatchRequest.',
              ),
            ),
          );
          coreA.pairing.register(
            method: 'wc_authRequest',
            function: (s, r) => {},
            type: ProtocolType.auth,
          );
          expect(
            () async =>
                await coreA.pairing.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              predicate(
                (e) =>
                    e is WalletConnectError &&
                    e.message ==
                        'Unsupported wc_ method. The following methods are not registered: wc_authBatchRequest.',
              ),
            ),
          );
        });

        test('succeeds when required methods are contained in registered',
            () async {
          List<RegisteredFunction> registeredFunctions = [
            RegisteredFunction(
              method: MethodConstants.WC_SESSION_PROPOSE,
              function: (s, r) => {},
              type: ProtocolType.sign,
            ),
            RegisteredFunction(
              method: 'wc_authRequest',
              function: (s, r) => {},
              type: ProtocolType.sign,
            ),
            RegisteredFunction(
              method: 'wc_authBatchRequest',
              function: (s, r) => {},
              type: ProtocolType.sign,
            )
          ];
          expect(
            JsonRpcUtils.validateMethods(
              ['wc_sessionPropose'],
              registeredFunctions,
            ),
            true,
          );
          expect(
            JsonRpcUtils.validateMethods(
              ['wc_sessionPropose', 'wc_authRequest'],
              registeredFunctions,
            ),
            true,
          );
          expect(
            JsonRpcUtils.validateMethods(
              ['wc_sessionPropose', 'wc_authRequest', 'wc_authBatchRequest'],
              registeredFunctions,
            ),
            true,
          );
        });
      });

      group('Ping', () {
        test('throws when unused topic is provided', () async {
          expect(
            () async => await coreA.pairing.ping(topic: 'abc'),
            throwsA(
              predicate((e) =>
                  e is WalletConnectError &&
                  e.message ==
                      "No matching key. pairing topic doesn't exist: abc"),
            ),
          );
        });
      });

      group('Disconnect', () {
        test('throws when unused topic is provided', () async {
          expect(
            () async => await coreA.pairing.disconnect(topic: 'abc'),
            throwsA(
              predicate((e) =>
                  e is WalletConnectError &&
                  e.message ==
                      "No matching key. pairing topic doesn't exist: abc"),
            ),
          );
        });
      });
    });
  });
}
