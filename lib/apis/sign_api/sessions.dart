import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

class Sessions extends GenericStore<SessionData> implements ISessions {
  Sessions({
    required super.storage,
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
      info = info.copyWith(expiry: expiry);
    }
    if (namespaces != null) {
      info = info.copyWith(namespaces: namespaces);
    }

    await set(topic, info);
  }
}
