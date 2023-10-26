import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/i_verify.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

class Verify implements IVerify {
  final ICore _core;
  final IHttpClient _httpClient;

  String name = WalletConnectConstants.VERIFY_CONTEXT;
  String? _verifyUrl;
  bool _initialized = false;
  // private isDevEnv;
  // the queue is only used during the loading phase of the iframe to ensure all attestations are posted
  List<String> _queue = [];
  // flag to disable verify when the iframe fails to load on main & fallback urls.
  // this means Verify API is not enabled for the current projectId and there's no point in trying to initialize it again.
  bool _verifyDisabled = false;

  Verify({
    required ICore core,
    required String projectId,
    required IHttpClient httpClient,
  })  : _core = core,
        _httpClient = httpClient;

  @override
  Future<void> init({String? verifyUrl}) async {
    if (_verifyDisabled) {
      return;
    }

    _verifyUrl = _getVerifyUrl(verifyUrl: verifyUrl);
  }

  @override
  Future<void> register({required String attestationId}) async {
    if (!_initialized) {
      _queue.add(attestationId);
      await init();
    } else {
      // this.sendPost(params.attestationId);
    }
  }

  @override
  Future<VerifyResult> resolve({required String attestationId}) async {
    VerifyResult verifyResult = VerifyResult(
      origin: '',
      validation: Validation.VALID,
      verifyUrl: '',
    );
    if (kDebugMode) {
      return verifyResult;
    }

    final vurl = _getVerifyUrl();
    try {
      final result = await _fetchAttestation(attestationId, vurl);
      debugPrint('result $result');
      // TODO set verifyResult
    } catch (error) {
      _core.logger.e(
        'failed to resolve attestation: $attestationId from url: $vurl',
      );
      _core.logger.e(error);
      final result = await _fetchAttestation(
        attestationId,
        WalletConnectConstants.VERIFY_FALLBACK_SERVER,
      );
      debugPrint('result $result');
      // TODO set verifyResult
    }
    return verifyResult;
  }

  Future<String?> _fetchAttestation(String attestationId, String url) async {
    _core.logger.i('resolving attestation: $attestationId from url: $url');
    // set artificial timeout to prevent hanging
    await Future.delayed(const Duration(seconds: 2));
    // const timeout = this.startAbortTimer(ONE_SECOND * 2);
    // const result = await fetch(`${url}/attestation/${attestationId}`, {
    //   signal: this.abortController.signal,
    // });
    final uri = Uri.parse('$url/attestation/$attestationId');
    final response = await _httpClient.get(uri);
    // clearTimeout(timeout);
    // return result.status === 200 ? await result.json() : undefined;
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  String _getVerifyUrl({String? verifyUrl}) {
    String url =
        (verifyUrl ?? _verifyUrl) ?? WalletConnectConstants.VERIFY_SERVER;
    if (!WalletConnectConstants.TRUSTED_VERIFY_URLS.contains(url)) {
      _core.logger.i(
          'verify url: $url, not included in trusted list, assigning default: ${WalletConnectConstants.VERIFY_SERVER}');
      url = WalletConnectConstants.VERIFY_SERVER;
    }
    return url;
  }
}
