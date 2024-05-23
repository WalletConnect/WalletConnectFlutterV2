import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_events.dart';

class WCAuthRequestModel {
  final String iss;
  final AuthRequest request;

  WCAuthRequestModel({
    required this.iss,
    required this.request,
  });
}
