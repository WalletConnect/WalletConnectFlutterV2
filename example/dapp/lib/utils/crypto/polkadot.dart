import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

enum PolkadotMethods {
  polkadotSignTransaction,
  polkadotSignMessage,
}

enum PolkadotEvents {
  none,
}

class Polkadot {
  static final Map<PolkadotMethods, String> methods = {
    PolkadotMethods.polkadotSignTransaction: 'polkadot_signTransaction',
    PolkadotMethods.polkadotSignMessage: 'polkadot_signMessage'
  };

  static final Map<PolkadotEvents, String> events = {};

  static Future<dynamic> callMethod({
    required IWeb3App web3App,
    required String topic,
    required String method,
    required String chainId,
    required String address,
  }) {
    switch (method) {
      case 'polkadot_signMessage':
        return web3App.request(
          topic: topic,
          chainId: chainId,
          request: SessionRequestParams(
            method: method,
            params: {
              'address': address,
              'message':
                  'This is an example message to be signed - ${DateTime.now()}',
            },
          ),
        );
      case 'polkadot_signTransaction':
        return web3App.request(
          topic: topic,
          chainId: chainId,
          request: SessionRequestParams(
            method: method,
            params: {
              'address': address,
              'transactionPayload': {
                'specVersion': '0x00002468',
                'transactionVersion': '0x0000000e',
                'address': address,
                'blockHash':
                    '0x554d682a74099d05e8b7852d19c93b527b5fae1e9e1969f6e1b82a2f09a14cc9',
                'blockNumber': '0x00cb539c',
                'era': '0xc501',
                'genesisHash':
                    '0xe143f23803ac50e8f6f8e62695d1ce9e4e1d68aa36c1cd2cfd15340213f3423e',
                'method':
                    '0x0001784920616d207369676e696e672074686973207472616e73616374696f6e21',
                'nonce': '0x00000000',
                'signedExtensions': [
                  'CheckNonZeroSender',
                  'CheckSpecVersion',
                  'CheckTxVersion',
                  'CheckGenesis',
                  'CheckMortality',
                  'CheckNonce',
                  'CheckWeight',
                  'ChargeTransactionPayment',
                ],
                'tip': '0x00000000000000000000000000000000',
                'version': 4,
              },
            },
          ),
        );
      default:
        throw 'Method unimplemented';
    }
  }
}
