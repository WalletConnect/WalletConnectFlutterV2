import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/namespace_utils.dart';
import 'package:wallet_connect_flutter_v2/wallet_connect_v2.dart';

class AuthApiValidators {
  bool isValidRequestExpiry(int expiry) {
    return AuthConstants.AUTH_REQUEST_EXPIRY_MIN <= expiry && expiry <= AuthConstants.AUTH_REQUEST_EXPIRY_MAX;
  }

  bool isValidRequest(AuthRequestParams params) {
    final validAudience = NamespaceUtils.isValidUrl(params.aud);
    final validChainId = true; //NamespaceUtils.isValidChainId(params.chainId);
    final domainInAud = params.aud.contains(RegExp(r'${params.domain}'));

    final hasNonce = params.nonce.isNotEmpty;
    final hasValidType = params.type == null || params.type == CacaoHeader.EIP4361;
    final expiry = params.expiry;
    if (expiry != null && !isValidRequestExpiry(expiry)) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context:
            'request() expiry: $expiry. Expiry must be a number (in seconds) between ${AuthConstants.AUTH_REQUEST_EXPIRY_MIN} and ${AuthConstants.AUTH_REQUEST_EXPIRY_MAX}',
      );
    }

    return validAudience && validChainId && domainInAud && hasNonce && hasValidType;
  }

  bool isValidRespond(RespondParams params, Map<int, PendingRequest> pendingRequests) {
    return pendingRequests.containsKey(params.id);
  }
}
