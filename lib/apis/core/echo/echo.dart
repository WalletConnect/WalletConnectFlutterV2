import 'package:walletconnect_flutter_v2/apis/core/echo/i_echo.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/i_echo_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';

class Echo implements IEcho {
  static const SUCCESS_STATUS = 'SUCCESS';
  final ICore core;
  final IEchoClient echoClient;

  Echo({required this.core, required this.echoClient});

  @override
  Future<void> register(String firebaseAccessToken) async {
    final projectId = core.projectId;
    final clientId = await core.crypto.getClientId();
    final response = await echoClient.register(
      projectId: projectId,
      clientId: clientId,
      firebaseAccessToken: firebaseAccessToken,
    );

    if (response.status != SUCCESS_STATUS) {
      if (response.errors != null && response.errors!.isNotEmpty) {
        throw ArgumentError(response.errors!.first.message);
      }

      throw Exception('Unknown error');
    }
  }

  @override
  Future<void> unregister() async {
    final projectId = core.projectId;
    final clientId = await core.crypto.getClientId();
    final response = await echoClient.unregister(
      projectId: projectId,
      clientId: clientId,
    );

    if (response.status != SUCCESS_STATUS) {
      if (response.errors != null && response.errors!.isNotEmpty) {
        throw ArgumentError(response.errors!.first.message);
      }

      throw Exception('Unknown error');
    }
  }
}
