import 'dart:convert';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:kadena_dart_sdk/models/walletconnect_models.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/kadena_test_files.dart'
    as kdtest;

const String testSignData = 'Test sign data';
String testSignTypedData(String address) => jsonEncode(
      {
        'types': {
          'EIP712Domain': [
            {"name": "name", "type": "string"},
            {"name": "version", "type": "string"},
            {"name": "chainId", "type": "uint256"},
            {"name": "verifyingContract", "type": "address"},
          ],
          'Person': [
            {'name': 'name', 'type': 'string'},
            {'name': 'wallet', 'type': 'address'},
          ],
        },
        'primaryType': 'Mail',
        'domain': {
          "name": "Ether Mail",
          "version": "1",
          "chainId": 1,
          "verifyingContract": "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",
        },
        'message': {
          "from": {"name": "Cow", "wallet": address},
          "to": {
            "name": "Bob",
            "wallet": "0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB"
          },
          "contents": "Hello, Bob!",
        },
      },
    );

/// KADENA ///

kdtest.SignRequest createSignRequest({
  required String networkId,
  required String signingPubKey,
  required String sender,
  String code = '"hello"',
  Map<String, dynamic>? data,
  List<DappCapp> caps = const [],
  String chainId = '1',
  int gasLimit = 2000,
  double gasPrice = 1e-8,
  int ttl = 600,
}) =>
    kdtest.SignRequest(
      code: code,
      data: data ?? {},
      sender: sender,
      networkId: networkId,
      chainId: chainId,
      gasLimit: gasLimit,
      gasPrice: gasPrice,
      signingPubKey: signingPubKey,
      ttl: ttl,
      caps: caps,
    );

PactCommandPayload createPactCommandPayload({
  required String networkId,
  required String sender,
  String code = '"hello"',
  Map<String, dynamic>? data,
  List<SignerCapabilities> signerCaps = const [],
  String chainId = '1',
  int gasLimit = 2000,
  double gasPrice = 1e-8,
  int ttl = 600,
}) =>
    PactCommandPayload(
      networkId: networkId,
      payload: CommandPayload(
        exec: ExecMessage(
          code: code,
          data: data ?? {},
        ),
      ),
      signers: signerCaps,
      meta: CommandMetadata(
        chainId: chainId,
        gasLimit: gasLimit,
        gasPrice: gasPrice,
        ttl: ttl,
        sender: sender,
      ),
    );

QuicksignRequest createQuicksignRequest({
  required String cmd,
  List<QuicksignSigner> sigs = const [],
}) =>
    QuicksignRequest(
      commandSigDatas: [
        CommandSigData(
          cmd: cmd,
          sigs: sigs,
        ),
      ],
    );

GetAccountsRequest createGetAccountsRequest({
  required String account,
}) =>
    GetAccountsRequest(
      accounts: [
        AccountRequest(
          account: account,
        ),
      ],
    );
