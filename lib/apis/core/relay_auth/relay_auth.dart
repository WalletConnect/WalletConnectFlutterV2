import 'dart:convert';
import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
import 'package:walletconnect_flutter_v2/apis/core/relay_auth/i_relay_auth.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_auth/relay_auth_models.dart';

class RelayAuth implements IRelayAuth {
  static const String multicodecEd25519Header = 'K36';
  static const String multicodecEd25519Base = 'z';
  static const int multicodecEd25519Length = 32;

  static const String JWT_DELIMITER = '.';

  static const String DID_DELIMITER = ':';
  static const String DID_PREFIX = 'did';
  static const String DID_METHOD = 'key';

  @override
  Future<RelayAuthKeyPair> generateKeyPair([Uint8List? seed]) async {
    ed.PrivateKey privateKey;
    ed.PublicKey publicKey;
    if (seed == null) {
      final keyPair = ed.generateKey();
      privateKey = keyPair.privateKey;
      publicKey = keyPair.publicKey;
    } else {
      privateKey = ed.newKeyFromSeed(seed);
      publicKey = ed.public(privateKey);
    }

    return RelayAuthKeyPair(
      Uint8List.fromList(privateKey.bytes),
      Uint8List.fromList(publicKey.bytes),
    );
  }

  @override
  Future<String> signJWT({
    required String sub,
    required String aud,
    required int ttl,
    required RelayAuthKeyPair keyPair,
    int? iat,
  }) async {
    iat ??= DateTime.now().millisecondsSinceEpoch ~/ 1000 - 60;
    final JWTHeader header = JWTHeader();
    final String iss = encodeIss(keyPair.publicKeyBytes);
    final int exp = iat + ttl;
    final JWTPayload payload = JWTPayload(
      iss,
      sub,
      aud,
      iat,
      exp,
    );
    final Uint8List data = encodeData(
      JWTData(
        header,
        payload,
      ),
    );
    Uint8List signature = ed.sign(
      ed.PrivateKey(keyPair.privateKeyBytes),
      data,
    );
    // List<int> signature = keyPair.sign(data);
    return encodeJWT(JWTSigned(signature, payload));
  }

  @override
  Future<bool> verifyJWT(String jwt) async {
    JWTDecoded decoded = decodeJWT(jwt);

    // Check the header
    if (decoded.header.alg != JWTHeader.JWT_ALG ||
        decoded.header.typ != JWTHeader.JWT_TYP) {
      throw VerifyJWTError(
        jwt,
        'JWT must use EdDSA algorithm',
      );
    }

    final Uint8List publicKey = decodeIss(decoded.payload.iss);
    return ed.verify(
      ed.PublicKey(publicKey),
      Uint8List.fromList(decoded.data),
      Uint8List.fromList(decoded.signature),
    );
    // final VerifyKey vKey = VerifyKey(publicKey);
    // final SignedMessage signedMessage = SignedMessage.fromList(
    //   signedMessage: Uint8List.fromList(
    //     decoded.signature,
    //   ),
    // );
    // return vKey.verify(
    //   signature: signedMessage.signature,
    //   message: Uint8List.fromList(decoded.data),
    // );
  }

  String stripEquals(String s) {
    return s.replaceAll('=', '');
  }

  @override
  String encodeJson(Map<String, dynamic> value) {
    return stripEquals(
      base64Url.encode(
        jsonEncode(
          value,
        ).codeUnits,
      ),
    );
  }

  @override
  Map<String, dynamic> decodeJson(String s) {
    return jsonDecode(
      utf8.decode(
        base64Url.decode(
          base64Url.normalize(
            s,
          ),
        ),
      ),
    );
  }

  /// Encodes the public key into a multicodec issuer
  @override
  String encodeIss(Uint8List publicKey) {
    Uint8List header = base58.decode(multicodecEd25519Header);
    final String multicodec =
        '$multicodecEd25519Base${base58.encode(Uint8List.fromList(header + publicKey))}';
    return <String>[
      DID_PREFIX,
      DID_METHOD,
      multicodec,
    ].join(DID_DELIMITER);
  }

  /// Gets the public key from the issuer
  @override
  Uint8List decodeIss(String issuer) {
    List<String> split = issuer.split(DID_DELIMITER);
    if (split[0] != DID_PREFIX || split[1] != DID_METHOD) {
      throw IssuerDecodeError(issuer, 'Issuer must be a DID with method "key"');
    }
    final String multicodec = split[2];

    // Check the base
    String base = multicodec[0];
    if (base != multicodecEd25519Base) {
      throw IssuerDecodeError(
        issuer,
        'Issuer must be a key in the multicodec format',
      );
    }

    // Decode
    final Uint8List bytes = base58.decode(multicodec.substring(1));

    // Check the header
    String header = base58.encode(bytes.sublist(0, 2));
    if (header != multicodecEd25519Header) {
      throw IssuerDecodeError(
        issuer,
        'Issuer must be a public key with type "Ed25519',
      );
    }

    // Slice off the public key and validate the length
    final Uint8List publicKey = bytes.sublist(2);
    if (publicKey.length != multicodecEd25519Length) {
      throw IssuerDecodeError(
        issuer,
        'Issuer must be public key with length 32 bytes',
      );
    }

    return publicKey;
  }

  @override
  Uint8List encodeData(JWTData params) {
    final String data = <String>[
      encodeJson(params.header.toJson()),
      encodeJson(params.payload.toJson()),
    ].join(JWT_DELIMITER);

    return Uint8List.fromList(utf8.encode(data));
  }

  @override
  JWTData decodeData(Uint8List data) {
    final List<String> params = utf8.decode(data).split(JWT_DELIMITER);

    JWTHeader header = JWTHeader.fromJson(jsonDecode(params[0]));
    JWTPayload payload = JWTPayload.fromJson(jsonDecode(params[1]));

    return JWTData(header, payload);
  }

  @override
  String encodeSig(Uint8List bytes) {
    return stripEquals(base64Url.encode(bytes));
  }

  @override
  Uint8List decodeSig(String encoded) {
    return Uint8List.fromList(base64Url.decode(base64Url.normalize(encoded)));
  }

  @override
  String encodeJWT(JWTSigned params) {
    return <String>[
      encodeJson(params.header.toJson()),
      encodeJson(params.payload.toJson()),
      encodeSig(Uint8List.fromList(params.signature)),
    ].join(JWT_DELIMITER);
  }

  @override
  JWTDecoded decodeJWT(String encoded) {
    final List<String> params = encoded.split(JWT_DELIMITER);

    JWTHeader header = JWTHeader.fromJson(decodeJson(params[0]));
    JWTPayload payload = JWTPayload.fromJson(decodeJson(params[1]));
    Uint8List signature = decodeSig(params[2]);
    List<int> data = utf8.encode(params.sublist(0, 2).join(JWT_DELIMITER));

    return JWTDecoded(data, signature, payload, header: header);
  }
}
