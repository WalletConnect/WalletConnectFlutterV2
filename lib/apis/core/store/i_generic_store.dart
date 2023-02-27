import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';

abstract class IGenericStore<T> {
  abstract final String version;
  abstract final String context;

  abstract final ICore core;
  abstract final String storageKey;

  abstract final dynamic Function(T) toJson;
  abstract final T Function(dynamic) fromJson;

  Future<void> restore();
  Future<void> persist();
  Future<void> init();
  bool has(String key);
  Future<void> set(String key, T value);
  T? get(String key);
  List<T> getAll();
  Future<void> delete(String key);
}
