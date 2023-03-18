// import 'dart:convert';

// import 'package:event/event.dart';
// import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
// import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';
// import 'package:walletconnect_flutter_v2/apis/sign_api/i_proposals.dart';
// import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
// import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
// import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

// class Proposals implements IProposals {
//   static const CONTEXT = 'proposals';
//   static const VERSION = '1.1';

//   @override
//   String get storageKey => '$VERSION//$CONTEXT';
//   @override
//   final ICore core;

//   @override
//   final Event<ProposalUpdateEvent> onUpdate = Event();

//   bool _initialized = false;

//   /// Stores map of topic to pairing info
//   Map<String, ProposalData> data = {};

//   /// Stores map of topic to pairing info as json encoded string
//   Map<String, String> dataStrings = {};

//   Proposals(this.core);

//   @override
//   Future<void> init() async {
//     if (_initialized) {
//       return;
//     }

//     await core.storage.init();
//     await restore();

//     _initialized = true;
//   }

//   @override
//   bool has(String topic) {
//     _checkInitialized();
//     return data.containsKey(topic);
//   }

//   @override
//   ProposalData? get(String topic) {
//     _checkInitialized();
//     if (data.containsKey(topic)) {
//       return data[topic]!;
//     }
//     return null;
//   }

//   @override
//   List<ProposalData> getAll() {
//     return data.values.toList();
//   }

//   @override
//   Future<void> set(String topic, ProposalData value) async {
//     _checkInitialized();
//     data[topic] = value;
//     dataStrings[topic] = jsonEncode(value.toJson());

//     onUpdate.broadcast(
//       ProposalUpdateEvent(
//         type: StoreUpdateEventType.set,
//         id: topic,
//         proposal: value,
//       ),
//     );

//     await persist();
//   }

//   @override
//   Future<void> delete(String topic) async {
//     _checkInitialized();
//     data.remove(topic);
//     dataStrings.remove(topic);

//     onUpdate.broadcast(
//       ProposalUpdateEvent(
//         type: StoreUpdateEventType.set,
//         id: topic,
//         proposal: value,
//       ),
//     );

//     await persist();
//   }

//   @override
//   Future<void> persist() async {
//     _checkInitialized();
//     await core.storage.set(storageKey, dataStrings);
//   }

//   @override
//   Future<void> restore() async {
//     if (core.storage.has(storageKey)) {
//       dataStrings = WalletConnectUtils.convertMapTo<String>(
//         core.storage.get(storageKey),
//       );
//       for (var entry in dataStrings.entries) {
//         data[entry.key] = ProposalData.fromJson(
//           jsonDecode(entry.value),
//         );
//       }
//     }
//   }

//   void _checkInitialized() {
//     if (!_initialized) {
//       throw Errors.getInternalError(Errors.NOT_INITIALIZED);
//     }
//   }
// }
