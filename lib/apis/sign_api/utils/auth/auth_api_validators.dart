import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/auth_constants.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class AuthApiValidators {
  static bool isValidRequestExpiry(int expiry) {
    return AuthConstants.AUTH_REQUEST_EXPIRY_MIN <= expiry &&
        expiry <= AuthConstants.AUTH_REQUEST_EXPIRY_MAX;
  }

  static bool isValidRequest(AuthRequestParams params) {
    if (!NamespaceUtils.isValidUrl(params.aud)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'requestAuth() invalid aud: ${params.aud}. Must be a valid url.',
      );
    }

    if (params.nonce.isEmpty) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'requestAuth() nonce must be nonempty.',
      );
    }

    // params.type == null || params.type == CacaoHeader.EIP4361
    if (params.type != null && params.type != CacaoHeader.EIP4361) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'requestAuth() type must null or ${CacaoHeader.EIP4361}.',
      );
    }

    final expiry = params.expiry;
    if (expiry != null && !isValidRequestExpiry(expiry)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'requestAuth() expiry: $expiry. Expiry must be a number (in seconds) between ${AuthConstants.AUTH_REQUEST_EXPIRY_MIN} and ${AuthConstants.AUTH_REQUEST_EXPIRY_MAX}',
      );
    }

    return true;
  }

  static bool isValidRespond({
    required int id,
    required Map<int, PendingAuthRequest> pendingRequests,
    CacaoSignature? signature,
    WalletConnectError? error,
  }) {
    if (!pendingRequests.containsKey(id)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'respondAuth() invalid id: $id. No pending request found.',
      );
    }

    if (signature == null && error == null) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'respondAuth() invalid response. Must contain either signature or error.',
      );
    }

    return true;
  }

  static bool isValidAuthenticate(SessionAuthRequestParams params) {
    if (params.chains.isEmpty) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'authenticate() invalid chains: Must not be emtpy.',
      );
    }

    if (!NamespaceUtils.isValidUrl(params.uri)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'authenticate() invalid uri: ${params.uri}. Must be a valid url.',
      );
    }

    if (params.nonce.isEmpty) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'authenticate() nonce must be nonempty.',
      );
    }

    if (params.type != null && params.type!.t != CacaoHeader.EIP4361) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'authenticate() type must null or ${CacaoHeader.EIP4361}.',
      );
    }

    final uniqueNamespaces = params.chains.map((chain) {
      return NamespaceUtils.getNamespaceFromChain(chain);
    }).toSet();
    if (uniqueNamespaces.length > 1) {
      throw Errors.getInternalError(
        Errors.NON_CONFORMING_NAMESPACES,
        context:
            'authenticate() Multi-namespace requests are not supported. Please request single namespace only.',
      );
    }

    final namespace = NamespaceUtils.getNamespaceFromChain(params.chains.first);
    if (namespace != 'eip155') {
      throw Errors.getInternalError(
        Errors.NON_CONFORMING_NAMESPACES,
        context:
            'authenticate() Only eip155 namespace is supported for authenticated sessions. Please use .connect() for non-eip155 chains.',
      );
    }

    return true;
  }

  static bool isValidRespondAuthenticate({
    required int id,
    required Map<int, PendingSessionAuthRequest> pendingRequests,
    List<Cacao>? auths,
  }) {
    if (!pendingRequests.containsKey(id)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'approveSessionAuthenticate() Could not find pending auth request with id $id',
      );
    }

    if (auths == null || auths.isEmpty) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'approveSessionAuthenticate() invalid response. Must contain Cacao signatures.',
      );
    }

    return true;
  }
}
