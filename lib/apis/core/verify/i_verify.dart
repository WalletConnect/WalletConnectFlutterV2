enum Validation {
  UNKNOWN,
  VALID,
  INVALID,
}

class VerifyResult {
  String origin;
  Validation validation;
  String verifyUrl;
  bool? isScam;

  VerifyResult({
    required this.origin,
    required this.validation,
    required this.verifyUrl,
  });
}

abstract class IVerify {
  // public abstract readonly context: string;
  // abstract String context;

  // constructor(public projectId: string, public logger: Logger) {}
  // IVerify({required String projectId});

  // public abstract init(params?: { verifyUrl?: string }): Promise<void>;
  Future<void> init({String? verifyUrl});

  // public abstract register(params: { attestationId: string }): Promise<void>;
  Future<void> register({required String attestationId});

  // public abstract resolve(params: {
  //   attestationId: string;
  //   verifyUrl?: string;
  // }): Promise<{ origin: string; isScam?: boolean }>;
  Future<VerifyResult> resolve({required String attestationId});

  // String getVerifyUrl({String? verifyUrl});
}
