import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/i_crypto.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_utils.mocks.dart';
import '../shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testMessage = jsonEncode({
    'id': 1,
    'jsonrpc': '2.0',
    'method': 'test_method',
    'params': {},
  });

  final testSelf = TEST_KEY_PAIRS['A']!;
  final testPeer = TEST_KEY_PAIRS['B']!;

  const TEST_IV = '717765636661617364616473';

  const TEST_SEALED =
      '7a5a1e843debf98b01d6a75718b5ee27115eafa3caba9703ca1c5601a6af2419045320faec2073cc8b6b8dc439e63e21612ff3883c867e0bdcd72c833eb7f7bb2034a9ec35c2fb03d93732';

  const TEST_ENCODED_TYPE_0 =
      'AHF3ZWNmYWFzZGFkc3paHoQ96/mLAdanVxi17icRXq+jyrqXA8ocVgGmryQZBFMg+uwgc8yLa43EOeY+IWEv84g8hn4L3Ncsgz6397sgNKnsNcL7A9k3Mg==';
  const TEST_ENCODED_TYPE_1 =
      'Af96fVdnw2KwoXrZIpnr23gx3L2aVpWcATaMdARUOzNCcXdlY2ZhYXNkYWRzeloehD3r+YsB1qdXGLXuJxFer6PKupcDyhxWAaavJBkEUyD67CBzzItrjcQ55j4hYS/ziDyGfgvc1yyDPrf3uyA0qew1wvsD2Tcy';

  group('Crypto API', () {
    late MockCryptoUtils mockUtils;
    late ICrypto cryptoAPI;
    late ICrypto cryptoApiUninitialized;

    setUp(() async {
      cryptoApiUninitialized = getCrypto();
      cryptoAPI = getCrypto();
      await cryptoAPI.init();
      // await cryptoAPI.core.start();
    });

    // test('Initializes the keychain a single time', () async {
    //   verify(keyChain.init()).called(1);
    //   await cryptoAPI.init();
    //   verifyNever(keyChain.init());
    // });

    group('generateKeyPair', () {
      test('Throws if not initialized', () async {
        cryptoAPI = getCrypto();
        expect(
          () async => await cryptoAPI.generateKeyPair(),
          throwsA(isA<WalletConnectError>()),
        );
      });

      test(
        'generates a keypair, sets it in the keychain and returns a public key',
        () async {
          final privateKey = CryptoUtils().generateRandomBytes32();
          final publicKey = CryptoUtils().generateRandomBytes32();
          mockUtils = MockCryptoUtils();
          when(mockUtils.generateKeyPair()).thenReturn(
            CryptoKeyPair(privateKey, publicKey),
          );
          cryptoAPI = getCrypto(
            utils: mockUtils,
          );
          await cryptoAPI.init();

          final String pubKeyActual = await cryptoAPI.generateKeyPair();
          verify(mockUtils.generateKeyPair()).called(1);
          // verify(keyChain.set(publicKey, privateKey)).called(1);
          expect(pubKeyActual, publicKey);
        },
      );
    });

    group('generateSharedKey', () {
      test('Throws if not initialized', () async {
        cryptoAPI = getCrypto();
        expect(
          () async => await cryptoAPI.generateSharedKey('a', 'b'),
          throwsA(isA<WalletConnectError>()),
        );
      });

      test(
        'generates a shared symKey, sets it in the keychain and returns the topic',
        () async {
          CryptoUtils utils = CryptoUtils();
          final overrideTopic = utils.generateRandomBytes32();
          final peerPublicKey = utils.generateRandomBytes32();
          final CryptoKeyPair selfKP = utils.generateKeyPair();
          final String expectedSymKey = await utils.deriveSymKey(
            selfKP.privateKey,
            peerPublicKey,
          );

          mockUtils = MockCryptoUtils();
          when(mockUtils.deriveSymKey(selfKP.privateKey, peerPublicKey))
              .thenAnswer(
            (_) async => expectedSymKey,
          );
          cryptoAPI = getCrypto(
            utils: mockUtils,
          );
          await cryptoAPI.init();
          await cryptoAPI.keyChain.set(selfKP.publicKey, selfKP.privateKey);

          final String topicActual = await cryptoAPI.generateSharedKey(
            selfKP.publicKey,
            peerPublicKey,
            overrideTopic: overrideTopic,
          );
          verify(mockUtils.deriveSymKey(selfKP.privateKey, peerPublicKey))
              .called(1);
          expect(topicActual, overrideTopic);
        },
      );
    });

    group('setSymKey', () {
      test('Throws if not initialized', () async {
        expect(
          () async => await cryptoApiUninitialized.setSymKey('a'),
          throwsA(isA<WalletConnectError>()),
        );
      });

      test(
        'sets expected topic-symKey pair in keychain, returns topic',
        () async {
          CryptoUtils utils = CryptoUtils();
          final fakeSymKey = utils.generateRandomBytes32();
          final topic = utils.hashKey(fakeSymKey);

          final topicActual = await cryptoAPI.setSymKey(fakeSymKey);

          expect(topicActual, topic);
        },
      );

      test(
        'sets expected topic-symKey pair in keychain it override topic is provided',
        () async {
          CryptoUtils utils = CryptoUtils();
          final fakeSymKey = utils.generateRandomBytes32();
          const topic = 'test-topic';

          final topicActual = await cryptoAPI.setSymKey(
            fakeSymKey,
            overrideTopic: topic,
          );

          expect(topicActual, topic);
        },
      );
    });

    group('deleteKeyPair', () {
      test('Throws if not initialized', () async {
        expect(
          () async => await cryptoApiUninitialized.deleteKeyPair('a'),
          throwsA(isA<WalletConnectError>()),
        );
      });

      test(
        'sets expected topic-symKey pair in keychain, returns topic',
        () async {
          CryptoUtils utils = CryptoUtils();
          final pubKey = utils.generateRandomBytes32();

          await cryptoAPI.keyChain.set(pubKey, 'test');

          expect(cryptoAPI.keyChain.get(pubKey), isNotNull);
          await cryptoAPI.deleteKeyPair(pubKey);

          expect(cryptoAPI.keyChain.get(pubKey), isNull);
        },
      );
    });

    group('deleteSymKey', () {
      test('Throws if not initialized', () async {
        expect(
          () async => await cryptoApiUninitialized.deleteSymKey('a'),
          throwsA(isA<WalletConnectError>()),
        );
      });

      test(
        'sets expected topic-symKey pair in keychain, returns topic',
        () async {
          CryptoUtils utils = CryptoUtils();
          final topic = utils.generateRandomBytes32();

          await cryptoAPI.keyChain.set(topic, 'test');

          expect(cryptoAPI.keyChain.get(topic), isNotNull);
          await cryptoAPI.deleteSymKey(topic);

          expect(cryptoAPI.keyChain.get(topic), isNull);
        },
      );
    });

    group('encode and decode', () {
      const SYM_KEY =
          '5720435e682cd03ee45b484f9a213f0e3246a0ccc2cca183b72ab1cbfbefb702';
      const PAYLOAD = {'id': 1, 'jsonrpc': '2.0', 'result': 'result'};
      const ENCODED =
          'AG7iJl9mMl9K04REnuWaKLQU6kwMcQWUd69OxGOJ5/A+VRRKkxnKhBeIAl4JRaIft3qZKEfnBvc7/Fife1DWcERqAfJwzPI=';

      test('Throws if not initialized', () async {
        expect(
          () async => await cryptoApiUninitialized.encode('a', {}),
          throwsA(isA<WalletConnectError>()),
        );
      });

      test(
        'encrypts payload if the passed topic is known',
        () async {
          final topic = await cryptoAPI.setSymKey(SYM_KEY);
          final String? encoded = await cryptoAPI.encode(topic, PAYLOAD);

          final String? decoded = await cryptoAPI.decode(topic, encoded!);
          expect(decoded, jsonEncode(PAYLOAD));

          final String? decoded2 = await cryptoAPI.decode(topic, ENCODED);
          expect(decoded2, jsonEncode(PAYLOAD));
        },
      );

      test(
        'returns null if the passed topic is known',
        () async {
          final topic = CryptoUtils().hashKey(SYM_KEY);
          final String? encoded = await cryptoAPI.encode(topic, PAYLOAD);
          expect(encoded, isNull);

          final String? decoded = await cryptoAPI.decode(topic, ENCODED);
          expect(decoded, isNull);
        },
      );
    });
  });

  group('Crypto Utils', () {
    CryptoUtils utils = CryptoUtils();
    test('should generate keypairs properly', () {
      CryptoKeyPair kp = utils.generateKeyPair();
      expect(kp.privateKey.length, 64);
      expect(kp.publicKey.length, 64);
    });

    test('can derive the sym key', () async {
      CryptoKeyPair kp1 = utils.generateKeyPair();
      CryptoKeyPair kp2 = utils.generateKeyPair();
      final String symKeyA = await utils.deriveSymKey(
        kp1.privateKey,
        kp2.publicKey,
      );
      final String symKeyB = await utils.deriveSymKey(
        kp2.privateKey,
        kp1.publicKey,
      );
      expect(symKeyA, symKeyB);
    });

    test('hashes key correctly', () {
      final String hashedKey = utils.hashKey(TEST_SHARED_KEY);
      expect(hashedKey, TEST_HASHED_KEY);
    });

    test('hashes messages correctly', () {
      const TEST_HASHED_MESSAGE =
          '15112289b5b794e68d1ea3cd91330db55582a37d0596f7b99ea8becdf9d10496';
      final String hashedKey = utils.hashMessage(testMessage);
      expect(hashedKey, TEST_HASHED_MESSAGE);
    });

    test('encrypt type 0 envelope', () async {
      final String encoded = await utils.encrypt(
        testMessage,
        TEST_SYM_KEY,
        iv: TEST_IV,
      );
      expect(encoded, TEST_ENCODED_TYPE_0);
      final EncodingParams deserialized = utils.deserialize(encoded);
      final String iv = hex.encode(deserialized.iv);
      expect(iv, TEST_IV);
      final String sealed = hex.encode(deserialized.sealed);
      expect(sealed, TEST_SEALED);
    });

    test('decrypts type 0 envelope properly', () async {
      final String decrypted = await utils.decrypt(
        TEST_SYM_KEY,
        TEST_ENCODED_TYPE_0,
      );
      expect(decrypted, testMessage);
    });

    test('encrypt (type 1)', () async {
      final String encoded = await utils.encrypt(
        testMessage,
        TEST_SYM_KEY,
        type: 1,
        iv: TEST_IV,
        senderPublicKey: testSelf.publicKey,
      );
      expect(encoded, TEST_ENCODED_TYPE_1);
      final EncodingParams deserialized = utils.deserialize(encoded);
      final String iv = hex.encode(deserialized.iv);
      expect(iv, TEST_IV);
      final String sealed = hex.encode(deserialized.sealed);
      expect(sealed, TEST_SEALED);
    });

    test('decrypt (type 1)', () async {
      const encoded = TEST_ENCODED_TYPE_1;
      final EncodingValidation params = utils.validateDecoding(
        encoded,
        receiverPublicKey: testPeer.publicKey,
      );
      expect(utils.isTypeOneEnvelope(params), true);
      expect(params.type, 1);
      expect(params.senderPublicKey, testSelf.publicKey);
      expect(params.receiverPublicKey, testPeer.publicKey);
      // print(
      //     await utils.deriveSymKey(TEST_PEER.privateKey, TEST_SELF.publicKey));
      final String symKey = await utils.deriveSymKey(
          testPeer.privateKey, params.senderPublicKey!);
      expect(symKey, TEST_SYM_KEY);
      final String decrypted = await utils.decrypt(symKey, encoded);
      expect(decrypted, testMessage);
    });
  });
}
