import 'dart:convert';

import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class Sessions extends GenericStore<SessionData> implements ISessions {
  Sessions({
    required super.core,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  @override
  Future<void> update(
    String topic, {
    int? expiry,
    Map<String, Namespace>? namespaces,
  }) async {
    checkInitialized();

    SessionData? info = get(topic);
    if (info == null) {
      return;
    }

    if (expiry != null) {
      info.expiry = expiry;
    }
    if (namespaces != null) {
      info.namespaces = namespaces;
    }

    onUpdate.broadcast(
      StoreUpdateEvent(
        topic,
        info,
      ),
    );

    await set(topic, info);
  }
}
