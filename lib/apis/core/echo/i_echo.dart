abstract class IEcho {
  Future<void> register(String firebaseAccessToken);
  Future<void> unregister();
}
