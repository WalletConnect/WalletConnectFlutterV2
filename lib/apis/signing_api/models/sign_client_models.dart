import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/session_models.dart';

class UriParameters {
  final String protocol;
  final int version;
  final String topic;
  final String symKey;
  final Relay relay;

  UriParameters(
    this.protocol,
    this.version,
    this.topic,
    this.symKey,
    this.relay,
  );
}

class ConnectResponse {
  final Completer session;
  final Uri? uri;

  ConnectResponse({
    required this.session,
    this.uri,
  });
}

class ApproveResponse {
  final String topic;
  final SessionData session;

  ApproveResponse({
    required this.topic,
    required this.session,
  });
}

class RejectParams {
  final int id;
  final String reason;

  RejectParams({
    required this.id,
    required this.reason,
  });
}
