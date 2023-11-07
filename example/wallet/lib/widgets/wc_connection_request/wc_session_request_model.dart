import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WCSessionRequestModel {
  final ProposalData request;
  final VerifyContext? verifyContext;

  WCSessionRequestModel({
    required this.request,
    this.verifyContext,
  });
}
