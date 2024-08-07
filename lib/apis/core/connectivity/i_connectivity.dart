import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/connectivity/connectivity_models.dart';

abstract class IConnectivity {
  abstract final Event<ConnectivityEvent> onConnectivityChange;
}
