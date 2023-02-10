import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/json_rpc_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_error.dart';

class AuthRequest extends EventArgs {
  final int id;
  final String topic;
  final AuthPayloadParams payloadParams;
  final ConnectionMetadata requester;

  AuthRequest({
    required this.id,
    required this.topic,
    required this.payloadParams,
    required this.requester,
  });
}

class AuthResponse extends EventArgs {
  final int id;
  final String topic;
  final Cacao? result;
  final WCError? error;
  final JsonRpcError? jsonRpcError;

  AuthResponse({
    required this.id,
    required this.topic,
    this.result,
    this.error,
    this.jsonRpcError,
  });
}
