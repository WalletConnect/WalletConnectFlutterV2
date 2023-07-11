// import 'dart:convert';

// import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
// import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
// import 'package:walletconnect_flutter_v2_dapp/utils/test_data.dart';

// enum KadenaMethods {
//   sign,
//   quicksign,
//   kadenaSignV1,
//   kadenaQuicksignV1,
//   kadenaGetAccountsV1,
// }

// enum KadenaEvents {
//   none,
// }

// extension KadenaMethodsX on KadenaMethods {
//   String? get value => Kadena.methods[this];
// }

// extension KadenaMethodsStringX on String {
//   KadenaMethods? toKadenaMethod() {
//     final entries = Kadena.methods.entries.where(
//       (element) => element.value == this,
//     );
//     return (entries.isNotEmpty) ? entries.first.key : null;
//   }
// }

// extension KadenaEventsX on KadenaEvents {
//   String? get value => Kadena.events[this];
// }

// extension KadenaEventsStringX on String {
//   KadenaEvents? toKadenaEvent() {
//     final entries = Kadena.events.entries.where(
//       (element) => element.value == this,
//     );
//     return (entries.isNotEmpty) ? entries.first.key : null;
//   }
// }

// class Kadena {
//   static final Map<KadenaMethods, String> methods = {
//     KadenaMethods.sign: 'kadena_sign',
//     KadenaMethods.quicksign: 'kadena_quicksign',
//     KadenaMethods.kadenaSignV1: 'kadena_sign_v1',
//     KadenaMethods.kadenaQuicksignV1: 'kadena_quicksign_v1',
//     KadenaMethods.kadenaGetAccountsV1: 'kadena_getAccounts_v1'
//   };

//   static final Map<KadenaEvents, String> events = {};

//   static Future<dynamic> callMethod({
//     required Web3App web3App,
//     required String topic,
//     required KadenaMethods method,
//     required String chainId,
//     required String address,
//   }) {
//     final String addressActual =
//         address.startsWith('k**') ? address.substring(3) : address;

//     switch (method) {
//       case KadenaMethods.sign:
//       case KadenaMethods.kadenaSignV1:
//         return kadenaSignV1(
//           web3App: web3App,
//           method: method,
//           topic: topic,
//           chainId: chainId,
//           data: createSignRequest(
//             networkId: chainId.split(':')[1],
//             signingPubKey: addressActual,
//             sender: 'k:$addressActual',
//             caps: [
//               DappCapp(
//                 role: 'Test',
//                 description: 'description',
//                 cap: Capability(
//                   name: 'coin.GAS',
//                 ),
//               ),
//               DappCapp(
//                 role: 'Test',
//                 description: 'description',
//                 cap: Capability(
//                   name: 'coin.TRANSFER',
//                   args: ['sender', 'receiver', 1.0],
//                 ),
//               ),
//             ],
//           ),
//         );
//       case KadenaMethods.quicksign:
//       case KadenaMethods.kadenaQuicksignV1:
//         return kadenaQuicksignV1(
//           web3App: web3App,
//           topic: topic,
//           chainId: chainId,
//           data: QuicksignRequest(
//             commandSigDatas: [
//               CommandSigData(
//                 cmd: jsonEncode(
//                   createPactCommandPayload(
//                     networkId: chainId.split(':')[1],
//                     sender: 'k:$addressActual',
//                     signerCaps: [
//                       SignerCapabilities(
//                         pubKey: addressActual,
//                         clist: [
//                           Capability(
//                             name: 'coin.GAS',
//                           ),
//                           Capability(
//                             name: 'coin.TRANSFER',
//                             args: ['sender', 'receiver', 1.0],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ).toJson(),
//                 ),
//                 sigs: [
//                   QuicksignSigner(
//                     pubKey: addressActual,
//                   ),
//                 ],
//               ),
//               CommandSigData(
//                 cmd: jsonEncode(
//                   createPactCommandPayload(
//                     networkId: chainId.split(':')[1],
//                     sender: 'k:$addressActual',
//                     signerCaps: [
//                       SignerCapabilities(
//                         pubKey: addressActual,
//                         clist: [
//                           Capability(
//                             name: 'coin.GAS',
//                           ),
//                           Capability(
//                             name: 'coin.TRANSFER',
//                             args: ['sender2', 'receiver2', 2.0],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ).toJson(),
//                 ),
//                 sigs: [
//                   QuicksignSigner(
//                     pubKey: addressActual,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );

//       case KadenaMethods.kadenaGetAccountsV1:
//         return kadenaGetAccountsV1(
//           web3App: web3App,
//           topic: topic,
//           chainId: chainId,
//           data: createGetAccountsRequest(account: '$chainId:$addressActual'),
//         );
//     }
//   }

//   static Future<dynamic> kadenaSignV1({
//     required Web3App web3App,
//     required KadenaMethods method,
//     required String topic,
//     required String chainId,
//     required SignRequest data,
//   }) async {
//     // print(jsonEncode(data));
//     final ret = await web3App.request(
//       topic: topic,
//       chainId: chainId,
//       request: SessionRequestParams(
//         method: methods[method]!,
//         params: data,
//       ),
//     );
//     // print('ret: $ret');
//     // print(ret.runtimeType);
//     return ret;
//   }

//   static Future<dynamic> kadenaQuicksignV1({
//     required Web3App web3App,
//     required String topic,
//     required String chainId,
//     required QuicksignRequest data,
//   }) async {
//     return await web3App.request(
//       topic: topic,
//       chainId: chainId,
//       request: SessionRequestParams(
//         method: methods[KadenaMethods.kadenaQuicksignV1]!,
//         params: data.toJson(),
//       ),
//     );
//   }

//   static Future<dynamic> kadenaGetAccountsV1({
//     required Web3App web3App,
//     required String topic,
//     required String chainId,
//     required GetAccountsRequest data,
//   }) async {
//     return await web3App.request(
//       topic: topic,
//       chainId: chainId,
//       request: SessionRequestParams(
//         method: methods[KadenaMethods.kadenaGetAccountsV1]!,
//         params: data.toJson(),
//       ),
//     );
//   }
// }
