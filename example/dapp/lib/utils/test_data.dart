import 'dart:convert';

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

const typedData =
    r'''{"types":{"EIP712Domain":[{"type":"string","name":"name"},{"type":"string","name":"version"},{"type":"uint256","name":"chainId"},{"type":"address","name":"verifyingContract"}],"Part":[{"name":"account","type":"address"},{"name":"value","type":"uint96"}],"Mint721":[{"name":"tokenId","type":"uint256"},{"name":"tokenURI","type":"string"},{"name":"creators","type":"Part[]"},{"name":"royalties","type":"Part[]"}]},"domain":{"name":"Mint721","version":"1","chainId":4,"verifyingContract":"0x2547760120aed692eb19d22a5d9ccfe0f7872fce"},"primaryType":"Mint721","message":{"@type":"ERC721","contract":"0x2547760120aed692eb19d22a5d9ccfe0f7872fce","tokenId":"1","uri":"ipfs://ipfs/hash","creators":[{"account":"0xc5eac3488524d577a1495492599e8013b1f91efa","value":10000}],"royalties":[],"tokenURI":"ipfs://ipfs/hash"}}''';

/// KADENA ///

// SignRequest createSignRequest({
//   required String networkId,
//   required String signingPubKey,
//   required String sender,
//   String code = '"hello"',
//   Map<String, dynamic>? data,
//   List<DappCapp> caps = const [],
//   String chainId = '1',
//   int gasLimit = 2000,
//   double gasPrice = 1e-8,
//   int ttl = 600,
// }) =>
//     SignRequest(
//       code: code,
//       data: data ?? {},
//       sender: sender,
//       networkId: networkId,
//       chainId: chainId,
//       gasLimit: gasLimit,
//       gasPrice: gasPrice,
//       signingPubKey: signingPubKey,
//       ttl: ttl,
//       caps: caps,
//     );

// PactCommandPayload createPactCommandPayload({
//   required String networkId,
//   required String sender,
//   String code = '"hello"',
//   Map<String, dynamic>? data,
//   List<SignerCapabilities> signerCaps = const [],
//   String chainId = '1',
//   int gasLimit = 2000,
//   double gasPrice = 1e-8,
//   int ttl = 600,
// }) =>
//     PactCommandPayload(
//       networkId: networkId,
//       payload: CommandPayload(
//         exec: ExecMessage(
//           code: code,
//           data: data ?? {},
//         ),
//       ),
//       signers: signerCaps,
//       meta: CommandMetadata(
//         chainId: chainId,
//         gasLimit: gasLimit,
//         gasPrice: gasPrice,
//         ttl: ttl,
//         sender: sender,
//       ),
//     );

// QuicksignRequest createQuicksignRequest({
//   required String cmd,
//   List<QuicksignSigner> sigs = const [],
// }) =>
//     QuicksignRequest(
//       commandSigDatas: [
//         CommandSigData(
//           cmd: cmd,
//           sigs: sigs,
//         ),
//       ],
//     );

// GetAccountsRequest createGetAccountsRequest({
//   required String account,
// }) =>
//     GetAccountsRequest(
//       accounts: [
//         AccountRequest(
//           account: account,
//         ),
//       ],
//     );
