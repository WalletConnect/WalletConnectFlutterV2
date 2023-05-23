import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:walletconnect_flutter_v2/apis/core/echo/i_echo_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/models/echo_body.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/models/echo_response.dart';

class EchoClient implements IEchoClient {
  static const headers = {'Content-Type': 'application/json'};
  final String baseUrl;

  EchoClient(this.baseUrl);

  @override
  Future<EchoResponse> register({
    required String projectId,
    required String clientId,
    required String firebaseAccessToken,
  }) async {
    final body = EchoBody(clientId: clientId, token: firebaseAccessToken);

    final url = Uri.parse('$baseUrl/$projectId/clients?auth=$clientId');
    final http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body.toJson()),
    );

    final jsonMap = json.decode(response.body);
    return EchoResponse.fromJson(jsonMap);
  }

  @override
  Future<EchoResponse> unregister({
    required String projectId,
    required String clientId,
  }) async {
    final url = Uri.parse('$baseUrl/$projectId/clients/$clientId');
    final http.Response response = await http.delete(url, headers: headers);

    final jsonMap = json.decode(response.body);
    return EchoResponse.fromJson(jsonMap);
  }
}
