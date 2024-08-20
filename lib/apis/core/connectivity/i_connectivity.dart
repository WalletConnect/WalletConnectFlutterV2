import 'package:flutter/foundation.dart';

abstract class IConnectivity {
  ValueNotifier<bool> get isOnline;
  Future<void> init();
}
