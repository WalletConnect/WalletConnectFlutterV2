import 'dart:convert';

import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/i_verify.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

class Verify implements IVerify {
  final ICore _core;
  final IHttpClient _httpClient;
  late String _verifyUrl;

  Verify({
    required ICore core,
    required IHttpClient httpClient,
  })  : _core = core,
        _httpClient = httpClient;

  @override
  Future<void> init({String? verifyUrl}) async {
    // TODO custom verifyUrl is not yet allowed.
    // Always using walletconnect urls for now
    _verifyUrl = _setVerifyUrl(verifyUrl: verifyUrl);
  }

  @override
  Future<AttestationResponse?> resolve({required String attestationId}) async {
    try {
      final uri = Uri.parse('$_verifyUrl/attestation/$attestationId');
      final response = await _httpClient.get(uri).timeout(Duration(seconds: 5));
      if (response.statusCode == 404 || response.body.isEmpty) {
        throw AttestationNotFound(
          code: 404,
          message: 'Attestion for this dapp could not be found',
        );
      }
      if (response.statusCode != 200) {
        throw Exception('Attestation response error: ${response.statusCode}');
      }
      return AttestationResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      _core.logger.d('[$runtimeType] resolve $e');
      rethrow;
    }
  }

  String _setVerifyUrl({String? verifyUrl}) {
    String url = verifyUrl ?? WalletConnectConstants.VERIFY_SERVER;

    if (!WalletConnectConstants.TRUSTED_VERIFY_URLS.contains(url)) {
      _core.logger.i(
        '[$runtimeType] verifyUrl $url not included in trusted list, '
        'assigning default: ${WalletConnectConstants.VERIFY_SERVER}',
      );
      url = WalletConnectConstants.VERIFY_SERVER;
    }
    return url;
  }
}
