import 'package:event/event.dart';

class ConnectivityEvent extends EventArgs {
  final bool connected;

  ConnectivityEvent(
    this.connected,
  );
}
