import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';

class URIParseResult {
  final String protocol;
  final String? version;
  final String topic;
  final String symKey;
  final Relay relay;
  final List<String> methods;

  URIParseResult({
    required this.protocol,
    required this.version,
    required this.topic,
    required this.symKey,
    required this.relay,
    required this.methods,
  });
}
