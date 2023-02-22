import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';

enum Eip155Methods {
  personalSign,
  ethSign,
  ethSignTransaction,
  ethSignTypedData,
  ethSignTypedDataV3,
  ethSignTypedDataV4,
  ethSendRawTransaction,
  ethSendTransaction,
}

enum Eip155Events {
  chainChanged,
  accountsChanged,
}

extension Eip155MethodsX on Eip155Methods {
  String? get value => Eip155Data.methods[this];
}

extension Eip155MethodsStringX on String {
  Eip155Methods? toEip155Method() {
    final entries =
        Eip155Data.methods.entries.where((element) => element.value == this);
    return (entries.isNotEmpty) ? entries.first.key : null;
  }
}

extension Eip155EventsX on Eip155Events {
  String? get value => Eip155Data.methods[this];
}

extension Eip155EventsStringX on String {
  Eip155Events? toEip155Event() {
    final entries =
        Eip155Data.events.entries.where((element) => element.value == this);
    return (entries.isNotEmpty) ? entries.first.key : null;
  }
}

class Eip155Data {
  static const List<ChainMetadata> mainChains = [
    ChainMetadata(
      chainId: 'eip155:1',
      name: 'Ethereum',
      logo: '/chain-logos/eip155-1.png',
      rpc: ['https://cloudflare-eth.com/'],
    ),
    ChainMetadata(
      chainId: 'eip155:137',
      name: 'Polygon',
      logo: '/chain-logos/eip155-137.png',
      rpc: ['https://polygon-rpc.com/'],
    ),
  ];

  static const List<ChainMetadata> testChains = [
    ChainMetadata(
      chainId: 'eip155:5',
      name: 'Ethereum Goerli',
      logo: '/chain-logos/eip155-1.png',
      rpc: ['https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'],
    ),
    ChainMetadata(
      chainId: 'eip155:80001',
      name: 'Polygon Mumbai',
      logo: '/chain-logos/eip155-137.png',
      rpc: ['https://matic-mumbai.chainstacklabs.com'],
    ),
  ];

  static const List<ChainMetadata> chains = [...mainChains, ...testChains];

  static final Map<Eip155Methods, String> methods = {
    Eip155Methods.personalSign: 'personal_sign',
    Eip155Methods.ethSign: 'eth_sign',
    Eip155Methods.ethSignTransaction: 'eth_signTransaction',
    Eip155Methods.ethSignTypedData: 'eth_signTypedData',
    Eip155Methods.ethSignTypedDataV3: 'eth_signTypedData_v3',
    Eip155Methods.ethSignTypedDataV4: 'eth_signTypedData_v4',
    Eip155Methods.ethSendRawTransaction: 'eth_sendRawTransaction',
    Eip155Methods.ethSendTransaction: 'eth_sendTransaction'
  };

  static final Map<Eip155Events, String> events = {
    Eip155Events.chainChanged: 'personal_sign',
    Eip155Events.accountsChanged: 'eth_sign',
  };
}
