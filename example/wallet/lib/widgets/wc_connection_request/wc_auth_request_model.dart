import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WCAuthRequestModel {
  final String iss;
  final AuthRequest request;

  WCAuthRequestModel({
    required this.iss,
    required this.request,
  });
}
