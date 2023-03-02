abstract class IKadenaHandler {
  Future<dynamic> handleSignRequest(String topic, dynamic payload);
  Future<dynamic> handleQuicksignRequest(String topic, dynamic payload);
}
