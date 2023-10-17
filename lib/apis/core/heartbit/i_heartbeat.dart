import 'package:event/event.dart';

abstract class IHeartBeat {
  abstract int interval;
  abstract final Event onPulse;

  void init();
  void stop();
}
