import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;

import 'package:pointycastle/digests/keccak.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/auth_constants.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/recaps_utils.dart';
import 'package:web3dart/crypto.dart' as crypto;

class AuthSignature {
  static final KeccakDigest keccakDigest = KeccakDigest(256);
  static Uint8List keccak256(Uint8List input) {
    keccakDigest.reset();
    return keccakDigest.process(input);
  }

  static Uint8List hashMessage(String message) {
    return keccak256(
      Uint8List.fromList(
        utf8.encode(
          [
            '\x19Ethereum Signed Message:\n',
            message.length.toString(),
            message,
          ].join(),
        ),
      ),
    );
  }

  static int getNormalizedV(int v) {
    if (v == 0 || v == 27) {
      return 27;
    }
    if (v == 1 || v == 28) {
      return 28;
    }
    return v & 1 == 1 ? 27 : 28;
  }

  static bool isValidEip191Signature(
    String address,
    String message,
    String sig,
  ) {
    // Get the sig bytes
    // print(sig);
    final sigBytes = Uint8List.fromList(
      hex.decode(sig.substring(2)),
    );

    // If the sig bytes aren't 65 bytes long, throw an error
    if (sigBytes.length != 65) {
      throw Exception('Invalid signature length');
    }

    // Get the r and s values from the sig bytes
    final r = BigInt.parse(
      hex.encode(sigBytes.sublist(0, 32)),
      radix: 16,
    );
    final s = BigInt.parse(
      hex.encode(sigBytes.sublist(32, 64)),
      radix: 16,
    );
    // print(sigBytes[64]);
    final v = getNormalizedV(sigBytes[64]);
    // print(r);
    // print(s);
    // print(v);

    // // Recover the public key from the signature
    // Uint8List? publicKeyBytes = AuthSecp256k1.recoverPublicKeyFromSignature(
    //   v - 27,
    //   r,
    //   s,
    //   hashMessage(message),
    // );

    // // If the public key is null, return false
    // if (publicKeyBytes == null) {
    //   print('Could not derive publicKey');
    //   return false;
    // }

    // Convert the public key to an address
    final publicKeyBytes = crypto.ecRecover(
      hashMessage(message),
      crypto.MsgSignature(r, s, v),
    );
    // print(hex.encode(publicKeyBytes));
    final hashedPubKeyBytes = keccak256(publicKeyBytes);
    final addressBytes = hashedPubKeyBytes.sublist(12, 32);
    final recoveredAddress = '0x${hex.encode(addressBytes)}';

    // final String recoveredAddress = EthSigUtil.recoverSignature(
    //   signature: sig,
    //   message: hashMessage(message),
    //   //  Uint8List.fromList(
    //   //   ascii.encode(message),
    //   // ),
    // );

    // print(recoveredAddress.toLowerCase());
    // print(address.toLowerCase());

    return recoveredAddress.toLowerCase() == address.toLowerCase();
  }

  static Future<bool> isValidEip1271Signature(
    String address,
    String reconstructedMessage,
    String cacaoSignature,
    String chainId,
    String projectId,
  ) async {
    try {
      const String eip1271MagicValue = '0x1626ba7e';
      const String dynamicTypeOffset =
          '0000000000000000000000000000000000000000000000000000000000000040';
      const String dynamicTypeLength =
          '0000000000000000000000000000000000000000000000000000000000000041';
      final String nonPrefixedSignature = cacaoSignature.substring(2);
      final String nonPrefixedHashedMessage =
          hex.encode(hashMessage(reconstructedMessage)).substring(2);

      final String data = eip1271MagicValue +
          nonPrefixedHashedMessage +
          dynamicTypeOffset +
          dynamicTypeLength +
          nonPrefixedSignature;

      final Uri url = Uri.parse(
        '${AuthConstants.AUTH_DEFAULT_URL}/?chainId=$chainId&projectId=$projectId',
      );
      final Map<String, dynamic> body = JsonRpcUtils.formatJsonRpcRequest(
        'eth_call',
        {
          'to': address,
          'data': data,
        },
      );

      final http.Response response = await http.post(
        url,
        body: body,
      );

      // print(response.body);
      // final jsonBody = jsonDecode(response.body);
      final String recoveredValue =
          response.body.substring(0, eip1271MagicValue.length);
      return recoveredValue.toLowerCase() == eip1271MagicValue.toLowerCase();
    } catch (e) {
      return false;
    }
  }

  // verifies CACAO signature
  // Used by the wallet after formatting the message
  static Future<bool> verifySignature(
    String address,
    String reconstructedMessage,
    CacaoSignature cacaoSignature,
    String chainId,
    String projectId,
  ) async {
    if (cacaoSignature.t == 'eip191') {
      return isValidEip191Signature(
        address,
        reconstructedMessage,
        cacaoSignature.s,
      );
    } else if (cacaoSignature.t == 'eip1271') {
      return await isValidEip1271Signature(
        address,
        reconstructedMessage,
        cacaoSignature.s,
        chainId,
        projectId,
      );
    } else {
      throw Exception(
        'verifySignature failed: Attempted to verify CacaoSignature with unknown type: ${cacaoSignature.t}',
      );
    }
  }

  static Cacao buildAuthObject({
    required CacaoRequestPayload requestPayload,
    required CacaoSignature signature,
    required String iss,
  }) {
    if (!iss.contains('did:pkh:')) {
      iss = 'did:pkh:$iss';
    }
    return Cacao(
      h: const CacaoHeader(t: CacaoHeader.CAIP122),
      p: CacaoPayload.fromRequestPayload(
        issuer: iss,
        payload: requestPayload,
      ),
      s: signature,
    );
  }

  static SessionAuthPayload populateAuthPayload({
    required SessionAuthPayload authPayload,
    required List<String> chains,
    required List<String> methods,
  }) {
    final statement = authPayload.statement ?? '';

    if (chains.isEmpty) return authPayload;

    final requested = authPayload.chains;
    final supported = chains;

    final approvedChains =
        supported.where((value) => requested.contains(value)).toList();
    if (approvedChains.isEmpty) {
      throw WalletConnectError(code: -1, message: 'No supported chains');
    }

    final requestedRecaps = ReCapsUtils.getDecodedRecapFromResources(
      resources: authPayload.resources,
    );
    if (requestedRecaps == null) return authPayload;

    ReCapsUtils.isValidRecap(requestedRecaps);

    final resource = ReCapsUtils.getRecapResource(
      recap: requestedRecaps,
      resource: 'eip155',
    );
    List<String> updatedResources = authPayload.resources ?? [];

    if (resource.isNotEmpty) {
      final actions = ReCapsUtils.getReCapActions(abilities: resource);
      final approvedActions =
          actions.where((value) => methods.contains(value)).toList();
      if (approvedActions.isEmpty) {
        throw WalletConnectError(
          code: -1,
          message: 'Supported methods don\'t satisfy the requested: $actions, '
              'supported: $methods',
        );
      }
      final formattedActions = ReCapsUtils.assignAbilityToActions(
        'request',
        approvedActions,
        limits: {'chains': approvedChains},
      );
      final updatedRecap = ReCapsUtils.addResourceToRecap(
        recap: requestedRecaps,
        resource: 'eip155',
        actions: formattedActions,
      );
      // remove recap from resources as we will add the updated one
      updatedResources = List<String>.from((authPayload.resources ?? []))
        ..removeLast();
      updatedResources.add(ReCapsUtils.encodeRecap(updatedRecap));
    }
    //
    return SessionAuthPayload.fromJson(authPayload.toJson()).copyWith(
      statement: ReCapsUtils.buildRecapStatement(
        statement,
        ReCapsUtils.getRecapFromResources(resources: updatedResources),
      ),
      chains: approvedChains,
      resources: updatedResources.isNotEmpty ? updatedResources : null,
    );
  }

  static String getAddressFromMessage(String message) {
    try {
      final regexp = RegExp('0x[a-fA-F0-9]{40}');
      final matches = regexp.allMatches(message);
      for (final Match m in matches) {
        return m[0]!;
      }
      return '';
    } catch (_) {}
    return '';
  }

  static String getChainIdFromMessage(String message) {
    try {
      final pattern = 'Chain ID: ';
      final regexp = RegExp('$pattern(?<temp1>\\d+)');
      final matches = regexp.allMatches(message);
      for (final Match m in matches) {
        return m[0]!.toString().replaceAll(pattern, '');
      }
    } catch (_) {}
    return '';
  }
}
