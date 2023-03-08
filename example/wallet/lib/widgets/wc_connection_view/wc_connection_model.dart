class WCConnectionModel {
  final String? title;
  final String? text;
  final List<String>? elements;

  WCConnectionModel({
    this.title,
    this.text,
    this.elements,
  });

  @override
  String toString() {
    return 'WalletConnectRequestModel(title: $title, text: $text, elements: $elements)';
  }
}
