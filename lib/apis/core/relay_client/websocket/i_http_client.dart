import 'package:http/http.dart' as http;

abstract class IHttpClient {
  const IHttpClient();

  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  });

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
  });
}
