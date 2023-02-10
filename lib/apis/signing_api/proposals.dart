import 'dart:convert';

import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_proposals.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/errors.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/wallet_connect_utils.dart';

class Proposals implements IProposals {
  static const CONTEXT = 'proposals';
  static const VERSION = '1.0';

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;

  /// Stores map of topic to pairing info
  Map<String, ProposalData> data = {};

  /// Stores map of topic to pairing info as json encoded string
  Map<String, String> dataStrings = {};

  Proposals(this.core);

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.storage.init();
    await restore();

    _initialized = true;
  }

  @override
  bool has(String topic) {
    _checkInitialized();
    return data.containsKey(topic);
  }

  @override
  ProposalData? get(String topic) {
    _checkInitialized();
    if (data.containsKey(topic)) {
      return data[topic]!;
    }
    return null;
  }

  @override
  List<ProposalData> getAll() {
    return data.values.toList();
  }

  @override
  Future<void> set(String topic, ProposalData value) async {
    _checkInitialized();
    data[topic] = value;
    dataStrings[topic] = jsonEncode(value.toJson());
    await persist();
  }

  @override
  Future<void> delete(String topic) async {
    _checkInitialized();
    data.remove(topic);
    dataStrings.remove(topic);
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, dataStrings);
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      dataStrings = WalletConnectUtils.convertMapTo<String>(
        core.storage.get(storageKey),
      );
      for (var entry in dataStrings.entries) {
        data[entry.key] = ProposalData.fromJson(
          jsonDecode(entry.value),
        );
      }
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
