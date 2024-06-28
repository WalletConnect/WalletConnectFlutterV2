import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';

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

  @override
  String toString() {
    return 'AuthRequest(id: $id, topic: $topic, payloadParams: $payloadParams, requester: $requester)';
  }
}

class AuthResponse extends EventArgs {
  final int id;
  final String topic;
  final Cacao? result;
  final WalletConnectError? error;
  final JsonRpcError? jsonRpcError;

  AuthResponse({
    required this.id,
    required this.topic,
    this.result,
    this.error,
    this.jsonRpcError,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        if (result != null) 'result': result?.toJson(),
        if (error != null) 'error': error!.toJson(),
        if (jsonRpcError != null) 'jsonRpcError': jsonRpcError!.toJson(),
      };

  @override
  String toString() {
    return 'AuthResponse(${jsonEncode(toJson())})';
  }
}
