import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';

enum URIVersion {
  v1,
  v2,
}

class URIParseResult {
  final String protocol;
  final String topic;
  final URIVersion? version;
  final URIV1ParsedData? v1Data;
  final URIV2ParsedData? v2Data;

  URIParseResult({
    required this.protocol,
    required this.version,
    required this.topic,
    this.v1Data,
    this.v2Data,
  });
}

class URIV1ParsedData {
  final String key;
  final String bridge;

  URIV1ParsedData({
    required this.key,
    required this.bridge,
  });
}

class URIV2ParsedData {
  final String symKey;
  final Relay relay;
  final List<String> methods;

  URIV2ParsedData({
    required this.symKey,
    required this.relay,
    required this.methods,
  });
}
