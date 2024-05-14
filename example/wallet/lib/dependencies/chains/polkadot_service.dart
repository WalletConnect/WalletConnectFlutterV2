import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';

import 'package:polkadart_keyring/polkadart_keyring.dart';

class PolkadotService {
  // final _bottomSheetService = GetIt.I<IBottomSheetService>();
  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;

  final ChainMetadata chainSupported;
  // late final Provider polkadotProvider;
  late final Keyring keyring;

  Map<String, dynamic Function(String, dynamic)> get polkadotRequestHandlers =>
      {
        'polkadot_signMessage': polkadotSignMessage,
        'polkadot_signTransaction': polkadotSignTransaction,
      };

  PolkadotService({required this.chainSupported}) {
    keyring = Keyring();
    // polkadotProvider = Provider.fromUri(Uri.parse(chainSupported.rpc.first));

    for (var handler in polkadotRequestHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _web3Wallet.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> polkadotSignMessage(String topic, dynamic parameters) async {
    debugPrint('[WALLET] polkadotSignMessage: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();
      debugPrint('[WALLET] polkadotSignMessage message: $message');

      // code
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final keyPair = await KeyPair.sr25519.fromMnemonic(keys[0].privateKey);
      keyPair.ss58Format = 1;

      if (await CommonMethods.requestApproval(message)) {
        final encodedMessage = utf8.encode(message);
        // final hex_ = hex.encode(utf8_);
        // debugPrint('[$runtimeType] encoded 0x$hex_');
        // final decoded = hex_.hexToUint8List();
        // debugPrint('[$runtimeType] decoded $decoded');
        final signature = keyPair.sign(encodedMessage);
        final isVerified = keyPair.verify(encodedMessage, signature);
        debugPrint('[$runtimeType] isVerified $isVerified');

        final hexSignature = hex.encode(signature);
        response = response.copyWith(
          result: {
            'signature': hexSignature,
          },
        );
      } else {
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e) {
      debugPrint('[WALLET] polkadotSignMessage error $e');
      response = response.copyWith(
        error: JsonRpcError(code: 0, message: e.toString()),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> polkadotSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[WALLET] polkadotSignTransaction: ${jsonEncode(parameters)}');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    // code
    //     String transferCall(String toAddress, BigInt value) {
    //   var pubkey = Address.decode(toAddress).pubkey;
    //   final dest = const $MultiAddress().id(pubkey);
    //   final runtimeCall =
    //       api.tx.balances.transferKeepAlive(dest: dest, value: value);
    //   return runtimeCall.encode().toHex().split0x();
    // }
    // code
    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final pair = await KeyPair.sr25519.fromMnemonic(keys[0].privateKey);
    pair.ss58Format = 1;

    // var toAddress = pair.address;
    // var pair = await keyring.createKeyPairFromMnemonic(mnemonic5);
    // debugPrint(
    //     'addr mnemonic: ${keyring.encodeAddress(pair.publicKey.bytes, 137)}');
    // debugPrint(
    //     'signer pub: ${Uint8List.fromList(pair.publicKey.bytes).toHex()}');
    // var balance = await method.getBalance(
    //   keyring.encodeAddress(pair.publicKey.bytes, 137),
    // );
    // debugPrint('balance:$balance');
    // var runtimeVersion = await method.getRuntimeVersion();
    // var blockNumber = await method.getBlockNumber();
    // var genesisHash = await method.getGenesisHash();
    // var blockHash = await method.getBlockHash();
    // debugPrint('blockHash: $blockHash');
    // debugPrint('genesisHash: $blockHash');
    // debugPrint('blockNumber: $blockNumber');
    // final methodCall = method.transferCall(toAddress, BigInt.from(1));
    // debugPrint('method call: $methodCall');
    // var nonce = await method.getNonce(pair.address);
    // debugPrint('nonce:$nonce');

    // SigningPayload payloadSign = SigningPayload(
    //   method: methodCall,
    //   specVersion: runtimeVersion.specVersion,
    //   transactionVersion: runtimeVersion.transactionVersion,
    //   genesisHash: genesisHash,
    //   blockHash: blockHash,
    //   blockNumber: blockNumber,
    //   eraPeriod: 64,
    //   nonce: nonce,
    //   tip: 0,
    // );

    // var payload = payloadSign.encode(method.getRegistry());
    // var signature = pair.sign(payload);
    // debugPrint('signature: ${signature.toHex()}');
    // var extrinsic = Extrinsic(
    //   signer: Uint8List.fromList(pair.publicKey.bytes).toHex().split0x(),
    //   method: methodCall,
    //   signature: signature.toHex().split0x(),
    //   eraPeriod: 64,
    //   blockNumber: blockNumber,
    //   nonce: nonce,
    //   tip: 0,
    // );

    // var raw = extrinsic.encode(method.getRegistry());
    // debugPrint('txRaw: ${raw.toHex()}');

    // var res = await method.sendTransaction(raw);
    // debugPrint('res is:$res');

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  void _onSessionRequest(SessionRequestEvent? args) async {
    if (args != null && args.chainId == chainSupported.chainId) {
      debugPrint('[WALLET] _onSessionRequest ${args.toString()}');
      final handler = polkadotRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }
}
