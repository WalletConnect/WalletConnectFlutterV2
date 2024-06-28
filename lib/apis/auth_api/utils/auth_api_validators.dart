// import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
// import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

// class AuthApiValidators {
//   static bool isValidRequestExpiry(int expiry) {
//     return AuthConstants.AUTH_REQUEST_EXPIRY_MIN <= expiry &&
//         expiry <= AuthConstants.AUTH_REQUEST_EXPIRY_MAX;
//   }

//   static bool isValidRequest(AuthRequestParams params) {
//     if (!NamespaceUtils.isValidUrl(params.aud)) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context:
//             'requestAuth() invalid aud: ${params.aud}. Must be a valid url.',
//       );
//     }
//     // final validChainId = true; //NamespaceUtils.isValidChainId(params.chainId);

//     if (!params.aud.contains(params.domain)) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context:
//             'requestAuth() invalid domain: ${params.domain}. aud must contain domain.',
//       );
//     }

//     if (params.nonce.isEmpty) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context: 'requestAuth() nonce must be nonempty.',
//       );
//     }

//     // params.type == null || params.type == CacaoHeader.EIP4361
//     if (params.type != null && params.type != CacaoHeader.EIP4361) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context: 'requestAuth() type must null or ${CacaoHeader.EIP4361}.',
//       );
//     }

//     final expiry = params.expiry;
//     if (expiry != null && !isValidRequestExpiry(expiry)) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context:
//             'requestAuth() expiry: $expiry. Expiry must be a number (in seconds) between ${AuthConstants.AUTH_REQUEST_EXPIRY_MIN} and ${AuthConstants.AUTH_REQUEST_EXPIRY_MAX}',
//       );
//     }

//     return true;
//   }

//   static bool isValidRespond({
//     required int id,
//     required Map<int, PendingAuthRequest> pendingRequests,
//     CacaoSignature? signature,
//     WalletConnectError? error,
//   }) {
//     if (!pendingRequests.containsKey(id)) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context: 'respondAuth() invalid id: $id. No pending request found.',
//       );
//     }

//     if (signature == null && error == null) {
//       throw Errors.getInternalError(
//         Errors.MISSING_OR_INVALID,
//         context:
//             'respondAuth() invalid response. Must contain either signature or error.',
//       );
//     }

//     return true;
//   }
// }
