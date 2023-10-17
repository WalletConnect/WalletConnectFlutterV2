import 'dart:async';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/heartbit/i_heartbeat.dart';

class HeartBeat implements IHeartBeat {
  Timer? _heartbeatTimer;

  @override
  int interval;

  HeartBeat({this.interval = 5});

  @override
  void init() {
    if (_heartbeatTimer != null) return;
    _heartbeatTimer = Timer.periodic(
      Duration(seconds: interval),
      (timer) => onPulse.broadcast(),
    );
  }

  @override
  void stop() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  @override
  final Event<EventArgs> onPulse = Event();
}
