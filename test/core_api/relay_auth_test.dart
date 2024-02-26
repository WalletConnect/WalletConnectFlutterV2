import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:walletconnect_flutter_v2/apis/core/relay_auth/relay_auth.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_auth/relay_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );

  group('Relay Auth/API', () {
    // Client will sign a unique identifier as the subject
    const TEST_SUBJECT =
        'c479fe5dc464e771e78b193d239a65b58d278cad1c34bfb0b5716e5bb514928e';

    // Client will include the server endpoint as audience
    const TEST_AUDIENCE = 'wss://relay.walletconnect.com';

    // Client will use the JWT for 24 hours
    const TEST_TTL = 86400;

    // Test issued at timestamp in seconds
    const TEST_IAT = 1656910097;

    // Test seed to generate the same key pair
    // const TEST_SEED =
    //     "58e0254c211b858ef7896b00e3f36beeb13d568d47c6031c4218b87718061295";

    // Expected secret key for above seed
    const EXPECTED_SECRET_KEY =
        '58e0254c211b858ef7896b00e3f36beeb13d568d47c6031c4218b87718061295884ab67f787b69e534bfdba8d5beb4e719700e90ac06317ed177d49e5a33be5a';

    const EXPECTED_PUBLIC_KEY =
        '884ab67f787b69e534bfdba8d5beb4e719700e90ac06317ed177d49e5a33be5a';

    // Expected issuer using did:key method
    const EXPECTED_ISS =
        'did:key:z6MkodHZwneVRShtaLf8JKYkxpDGp1vGZnpGmdBpX8M2exxH';

    // Expected expiry given injected issued at
    const EXPECTED_EXP = TEST_IAT + TEST_TTL;

    // Expected data encode for given payload
    const EXPECTED_DATA =
        'eyJhbGciOiJFZERTQSIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkaWQ6a2V5Ono2TWtvZEhad25lVlJTaHRhTGY4SktZa3hwREdwMXZHWm5wR21kQnBYOE0yZXh4SCIsInN1YiI6ImM0NzlmZTVkYzQ2NGU3NzFlNzhiMTkzZDIzOWE2NWI1OGQyNzhjYWQxYzM0YmZiMGI1NzE2ZTViYjUxNDkyOGUiLCJhdWQiOiJ3c3M6Ly9yZWxheS53YWxsZXRjb25uZWN0LmNvbSIsImlhdCI6MTY1NjkxMDA5NywiZXhwIjoxNjU2OTk2NDk3fQ';

    // Expected signature for given data
    const EXPECTED_SIG =
        'bAKl1swvwqqV_FgwvD4Bx3Yp987B9gTpZctyBviA-EkAuWc8iI8SyokOjkv9GJESgid4U8Tf2foCgrQp2qrxBA';

    // Expected JWT for given payload
    const EXPECTED_JWT =
        'eyJhbGciOiJFZERTQSIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkaWQ6a2V5Ono2TWtvZEhad25lVlJTaHRhTGY4SktZa3hwREdwMXZHWm5wR21kQnBYOE0yZXh4SCIsInN1YiI6ImM0NzlmZTVkYzQ2NGU3NzFlNzhiMTkzZDIzOWE2NWI1OGQyNzhjYWQxYzM0YmZiMGI1NzE2ZTViYjUxNDkyOGUiLCJhdWQiOiJ3c3M6Ly9yZWxheS53YWxsZXRjb25uZWN0LmNvbSIsImlhdCI6MTY1NjkxMDA5NywiZXhwIjoxNjU2OTk2NDk3fQ.bAKl1swvwqqV_FgwvD4Bx3Yp987B9gTpZctyBviA-EkAuWc8iI8SyokOjkv9GJESgid4U8Tf2foCgrQp2qrxBA';

    // Expected decoded JWT using did-jwt
    final expectedDecoded = JWTDecoded(
      Uint8List.fromList(utf8.encode(EXPECTED_DATA)),
      Uint8List.fromList(utf8.encode(EXPECTED_SIG)),
      JWTPayload(
        EXPECTED_ISS,
        TEST_SUBJECT,
        TEST_AUDIENCE,
        TEST_IAT,
        EXPECTED_EXP,
      ),
    );

    RelayAuthKeyPair keyPair = RelayAuthKeyPair.fromStrings(
      EXPECTED_SECRET_KEY,
      EXPECTED_PUBLIC_KEY,
    );

    late RelayAuth relayAuth;
    late RelayAuth relayApi;

    setUp(() async {
      relayAuth = RelayAuth();
      relayApi = RelayAuth();
    });

    test('encode and decode issuer', () async {
      String iss = relayAuth.encodeIss(keyPair.publicKeyBytes);
      expect(iss, EXPECTED_ISS);
      Uint8List publicKey = relayAuth.decodeIss(iss);
      expect(publicKey, keyPair.publicKeyBytes);
    });

    test('encode and decode data', () async {
      Uint8List data = relayAuth.encodeData(expectedDecoded);
      expect(data, utf8.encode(EXPECTED_DATA));
    });

    test('Sign and verify JWT', () async {
      RelayAuthKeyPair keyPair1 = RelayAuthKeyPair.fromStrings(
        'db74f4788fbaf87bc8e3cd6a84ae82586fd4fd701216a1d18f7ed936cb3a8cfb579e2b8f7190abb558ee5461a852389bdff6079b3a4eabc3e759a7775334f7f7',
        '579e2b8f7190abb558ee5461a852389bdff6079b3a4eabc3e759a7775334f7f7',
      );
      String jwt1 = await relayApi.signJWT(
        sub: '6a26d1c13b8f7bfda6e7415f6db94084a3b97f2990da5216fa5aa7b80f08391d',
        aud: TEST_AUDIENCE,
        ttl: WalletConnectConstants.ONE_DAY,
        keyPair: keyPair1,
        iat: 1674244632,
      );
      expect(
        jwt1,
        'eyJhbGciOiJFZERTQSIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJkaWQ6a2V5Ono2TWtrTUhRRlYzYkNUOXVIV3Z6Z1N4UXNMbVZzMVc1c0NVdzhyQnBmamg5ZHNydiIsInN1YiI6IjZhMjZkMWMxM2I4ZjdiZmRhNmU3NDE1ZjZkYjk0MDg0YTNiOTdmMjk5MGRhNTIxNmZhNWFhN2I4MGYwODM5MWQiLCJhdWQiOiJ3c3M6Ly9yZWxheS53YWxsZXRjb25uZWN0LmNvbSIsImlhdCI6MTY3NDI0NDYzMiwiZXhwIjoxNjc0MzMxMDMyfQ.FUfsQtGuyMTOfEjQUdfr_KfBEaftEQPU9lpQ_mNwgpPlzqk2Hmn9RKnbTnvL9rPWzbm5wnWrc7LuzUQGqp99Cw',
      );

      String jwt = await relayApi.signJWT(
        sub: TEST_SUBJECT,
        aud: TEST_AUDIENCE,
        ttl: TEST_TTL,
        keyPair: keyPair,
        iat: TEST_IAT,
      );
      expect(jwt, EXPECTED_JWT);
      bool verified = await relayApi.verifyJWT(jwt);
      expect(verified, true);
    });
  });
}
