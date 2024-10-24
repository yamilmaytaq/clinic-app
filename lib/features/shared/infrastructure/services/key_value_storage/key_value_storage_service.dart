abstract class KeyValueStorageService {
  Future<void> setKey<T>(String key, T value);
  Future<T?> getKey<T>(String key);
  Future<bool> removeKey(String key);
}
