enum WCSignType {
  MESSAGE,
  PERSONAL_MESSAGE,
  TYPED_MESSAGE_V1,
  TYPED_MESSAGE_V3,
  TYPED_MESSAGE_V4
}

class EthereumSignMessage {
  final String data;
  final String address;
  final WCSignType type;

  const EthereumSignMessage({
    required this.data,
    required this.address,
    required this.type,
  });
}
