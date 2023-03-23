import 'package:http/http.dart' as http;

abstract class IHttpClient {
  const IHttpClient();

  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  });
}
