import 'package:http/http.dart' as http;
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';

class HttpWrapper extends IHttpClient {
  const HttpWrapper();

  @override
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    return await http.get(url, headers: headers);
  }

  @override
  Future<http.Response> delete(Uri url, {Map<String, String>? headers}) async {
    return await http.delete(url, headers: headers);
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(url, headers: headers, body: body);
  }
}
