import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';

abstract class IVerify {
  Future<void> init({String? verifyUrl});

  Future<AttestationResponse?> resolve({required String attestationId});
}
