import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_models.dart';

class SessionAuthRequest extends EventArgs {
  final int id;
  final String topic;
  final SessionAuthPayload authPayload;
  final ConnectionMetadata requester;
  final VerifyContext? verifyContext;

  SessionAuthRequest({
    required this.id,
    required this.topic,
    required this.authPayload,
    required this.requester,
    this.verifyContext,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        'authPayload': authPayload.toJson(),
        'requester': requester.toJson(),
        'verifyContext': verifyContext?.toJson(),
      };

  @override
  String toString() {
    return 'SessionAuthRequest(${jsonEncode(toJson())})';
  }
}

class SessionAuthResponse extends EventArgs {
  final int id;
  final String topic;
  final List<Cacao>? auths;
  final SessionData? session;
  final WalletConnectError? error;
  final JsonRpcError? jsonRpcError;

  SessionAuthResponse({
    required this.id,
    required this.topic,
    this.auths,
    this.session,
    this.error,
    this.jsonRpcError,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic': topic,
        if (auths != null) 'auths': auths,
        if (session != null) 'session': session!.toJson(),
        if (error != null) 'error': error!.toJson(),
        if (jsonRpcError != null) 'jsonRpcError': jsonRpcError!.toJson(),
      };

  @override
  String toString() {
    return 'SessionAuthResponse(${jsonEncode(toJson())})';
  }
}
