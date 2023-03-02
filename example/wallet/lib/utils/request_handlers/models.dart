import 'dart:async';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

class SignRequestBase {
  final Completer completer;

  SignRequestBase({
    required this.completer,
  });
}

class KadenaSignRequest extends SignRequestBase {
  SignRequest request;

  KadenaSignRequest({
    required super.completer,
    required this.request,
  });
}

class KadenaQuicksignRequest extends SignRequestBase {
  QuicksignRequest request;

  KadenaQuicksignRequest({
    required super.completer,
    required this.request,
  });
}
