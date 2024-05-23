// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:convert/convert.dart';
// import 'package:http/http.dart' as http;

// import 'package:pointycastle/digests/keccak.dart';
// import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
// import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
// import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
// import 'package:web3dart/crypto.dart' as crypto;

// class AuthSignature {
//   static final KeccakDigest keccakDigest = KeccakDigest(256);
//   static Uint8List keccak256(Uint8List input) {
//     keccakDigest.reset();
//     return keccakDigest.process(input);
//   }

//   static Uint8List hashMessage(String message) {
//     return keccak256(
//       Uint8List.fromList(
//         utf8.encode(
//           [
//             '\x19Ethereum Signed Message:\n',
//             message.length.toString(),
//             message,
//           ].join(),
//         ),
//       ),
//     );
//   }

//   static int getNormalizedV(int v) {
//     if (v == 0 || v == 27) {
//       return 27;
//     }
//     if (v == 1 || v == 28) {
//       return 28;
//     }
//     return v & 1 == 1 ? 27 : 28;
//   }

//   static bool isValidEip191Signature(
//     String address,
//     String message,
//     String sig,
//   ) {
//     // Get the sig bytes
//     // print(sig);
//     final sigBytes = Uint8List.fromList(
//       hex.decode(sig.substring(2)),
//     );

//     // If the sig bytes aren't 65 bytes long, throw an error
//     if (sigBytes.length != 65) {
//       throw Exception('Invalid signature length');
//     }

//     // Get the r and s values from the sig bytes
//     final r = BigInt.parse(
//       hex.encode(sigBytes.sublist(0, 32)),
//       radix: 16,
//     );
//     final s = BigInt.parse(
//       hex.encode(sigBytes.sublist(32, 64)),
//       radix: 16,
//     );
//     // print(sigBytes[64]);
//     final v = getNormalizedV(sigBytes[64]);
//     // print(r);
//     // print(s);
//     // print(v);

//     // // Recover the public key from the signature
//     // Uint8List? publicKeyBytes = AuthSecp256k1.recoverPublicKeyFromSignature(
//     //   v - 27,
//     //   r,
//     //   s,
//     //   hashMessage(message),
//     // );

//     // // If the public key is null, return false
//     // if (publicKeyBytes == null) {
//     //   print('Could not derive publicKey');
//     //   return false;
//     // }

//     // Convert the public key to an address
//     final publicKeyBytes = crypto.ecRecover(
//       hashMessage(message),
//       crypto.MsgSignature(r, s, v),
//     );
//     // print(hex.encode(publicKeyBytes));
//     final hashedPubKeyBytes = keccak256(publicKeyBytes);
//     final addressBytes = hashedPubKeyBytes.sublist(12, 32);
//     final recoveredAddress = '0x${hex.encode(addressBytes)}';

//     // final String recoveredAddress = EthSigUtil.recoverSignature(
//     //   signature: sig,
//     //   message: hashMessage(message),
//     //   //  Uint8List.fromList(
//     //   //   ascii.encode(message),
//     //   // ),
//     // );

//     // print(recoveredAddress.toLowerCase());
//     // print(address.toLowerCase());

//     return recoveredAddress.toLowerCase() == address.toLowerCase();
//   }

//   static Future<bool> isValidEip1271Signature(
//     String address,
//     String reconstructedMessage,
//     String cacaoSignature,
//     String chainId,
//     String projectId,
//   ) async {
//     try {
//       const String eip1271MagicValue = '0x1626ba7e';
//       const String dynamicTypeOffset =
//           '0000000000000000000000000000000000000000000000000000000000000040';
//       const String dynamicTypeLength =
//           '0000000000000000000000000000000000000000000000000000000000000041';
//       final String nonPrefixedSignature = cacaoSignature.substring(2);
//       final String nonPrefixedHashedMessage =
//           hex.encode(hashMessage(reconstructedMessage)).substring(2);

//       final String data = eip1271MagicValue +
//           nonPrefixedHashedMessage +
//           dynamicTypeOffset +
//           dynamicTypeLength +
//           nonPrefixedSignature;

//       final Uri url = Uri.parse(
//         '${AuthConstants.AUTH_DEFAULT_URL}/?chainId=$chainId&projectId=$projectId',
//       );
//       final Map<String, dynamic> body = JsonRpcUtils.formatJsonRpcRequest(
//         'eth_call',
//         {
//           'to': address,
//           'data': data,
//         },
//       );

//       final http.Response response = await http.post(
//         url,
//         body: body,
//       );

//       // print(response.body);
//       // final jsonBody = jsonDecode(response.body);
//       final String recoveredValue =
//           response.body.substring(0, eip1271MagicValue.length);
//       return recoveredValue.toLowerCase() == eip1271MagicValue.toLowerCase();
//     } catch (e) {
//       return false;
//     }
//   }

//   // verifies CACAO signature
//   // Used by the wallet after formatting the message
//   static Future<bool> verifySignature(
//     String address,
//     String reconstructedMessage,
//     CacaoSignature cacaoSignature,
//     String chainId,
//     String projectId,
//   ) async {
//     if (cacaoSignature.t == 'eip191') {
//       return isValidEip191Signature(
//         address,
//         reconstructedMessage,
//         cacaoSignature.s,
//       );
//     } else if (cacaoSignature.t == 'eip1271') {
//       return await isValidEip1271Signature(
//         address,
//         reconstructedMessage,
//         cacaoSignature.s,
//         chainId,
//         projectId,
//       );
//     } else {
//       throw Exception(
//         'verifySignature failed: Attempted to verify CacaoSignature with unknown type: ${cacaoSignature.t}',
//       );
//     }
//   }
// }
