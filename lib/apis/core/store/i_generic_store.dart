import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';

abstract class IGenericStore<T> {
  abstract final String version;
  abstract final String context;

  abstract final ICore core;
  abstract final String storageKey;

  // abstract final dynamic Function(T) toJson;
  abstract final T Function(dynamic) fromJson;

  abstract final Event<StoreCreateEvent<T>> onCreate;
  abstract final Event<StoreUpdateEvent<T>> onUpdate;
  abstract final Event<StoreDeleteEvent<T>> onDelete;
  abstract final Event<StoreSyncEvent<T>> onSync;

  Future<void> restore();
  Future<void> persist();
  Future<void> init();
  bool has(String key);
  Future<void> set(String key, T value);
  T? get(String key);
  List<T> getAll();
  Future<void> delete(String key);
}
