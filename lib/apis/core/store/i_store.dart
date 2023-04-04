abstract class IStore<T> {
  abstract final Map<String, T> map;
  abstract final List<String> keys;
  abstract final List<T> values;
  abstract final String storagePrefix;

  Future<void> init();
  Future<void> set(String key, T value);
  T? get(String key);
  bool has(String key);
  List<dynamic> getAll();
  Future<void> update(String key, T value);
  Future<void> delete(String key);
}
