import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_common_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

class OCARequest extends EventArgs {
  // TODO to be implemented for wallet usage
}

class OCAResponse extends EventArgs {
  final int id;
  final String topic;
  final List<Cacao>? auths;
  final SessionData? session;
  final WalletConnectError? error;
  final JsonRpcError? jsonRpcError;

  OCAResponse({
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
    return 'OCAResponse(${jsonEncode(toJson())})';
  }
}
