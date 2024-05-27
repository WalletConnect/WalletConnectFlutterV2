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
    required String projectId,
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
    AttestationResponse? response;
    try {
      response = await _fetchAttestation(attestationId, _verifyUrl);
    } on AttestationNotFound catch (e) {
      _core.logger.i(e.message);
      response = await _fetchAttestation(
        attestationId,
        WalletConnectConstants.VERIFY_FALLBACK_SERVER,
      );
    } on Exception catch (error) {
      _core.logger.e(error);
      response = await _fetchAttestation(
        attestationId,
        WalletConnectConstants.VERIFY_FALLBACK_SERVER,
      );
    }
    return response;
  }

  Future<AttestationResponse> _fetchAttestation(
    String attestationId,
    String url,
  ) async {
    final uri = Uri.parse('$url/attestation/$attestationId');
    final response = await _httpClient.get(uri);
    if (response.statusCode == 404) {
      throw AttestationNotFound(
        code: 404,
        message: 'Attestion for this dapp could not be found',
      );
    }
    if (response.statusCode != 200) {
      final error = 'Attestation response error: ${response.statusCode}';
      throw Exception(error);
    }
    if (response.body.isEmpty) {
      throw AttestationNotFound(
        code: 404,
        message: 'Attestion for this dapp could not be found',
      );
    }
    return AttestationResponse.fromJson(jsonDecode(response.body));
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
