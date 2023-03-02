import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/request_handlers/models.dart';

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
