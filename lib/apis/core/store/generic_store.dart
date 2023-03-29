import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';

class GenericStore<T> implements IGenericStore<T> {
  @override
  final String context;
  @override
  final String version;

  @override
  String get storageKey => '$version//$context';
  @override
  final IStore storage;

  @override
  final Event<StoreCreateEvent<T>> onCreate = Event();
  @override
  final Event<StoreUpdateEvent<T>> onUpdate = Event();
  @override
  final Event<StoreDeleteEvent<T>> onDelete = Event();
  @override
  final Event<StoreSyncEvent> onSync = Event();

  bool _initialized = false;

  /// Stores map of key to pairing info
  Map<String, T> data = {};

  @override
  final T Function(dynamic) fromJson;

  GenericStore({
    required this.storage,
    required this.context,
    required this.version,
    required this.fromJson,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await storage.init();
    await restore();

    _initialized = true;
  }

  @override
  bool has(String key) {
    checkInitialized();
    return data.containsKey(key);
  }

  @override
  T? get(String key) {
    checkInitialized();
    if (data.containsKey(key)) {
      return data[key]!;
    }
    return null;
  }

  @override
  List<T> getAll() {
    return data.values.toList();
  }

  @override
  Future<void> set(String key, T value) async {
    checkInitialized();

    if (data.containsKey(key)) {
      onUpdate.broadcast(
        StoreUpdateEvent(
          key,
          value,
        ),
      );
    } else {
      onCreate.broadcast(
        StoreCreateEvent(
          key,
          value,
        ),
      );
    }

    data[key] = value;

    await persist();
  }

  @override
  Future<void> delete(String key) async {
    checkInitialized();

    if (!data.containsKey(key)) {
      return;
    }

    onDelete.broadcast(
      StoreDeleteEvent(
        key,
        data.remove(key)!,
      ),
    );

    await persist();
  }

  @override
  Future<void> persist() async {
    checkInitialized();

    onSync.broadcast(
      StoreSyncEvent(),
    );

    await storage.set(storageKey, data);
  }

  @override
  Future<void> restore() async {
    if (storage.has(storageKey)) {
      // print('Restoring $storageKey');
      for (var entry in storage.get(storageKey).entries) {
        data[entry.key] = fromJson(entry.value);
      }
    }
  }

  @protected
  void checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
