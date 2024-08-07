import 'package:walletconnect_flutter_v2/apis/core/connectivity/connectivity_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/connectivity/i_connectivity.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class Connectivity implements IConnectivity {
  @override
  Event<ConnectivityEvent> onConnectivityChange = Event<ConnectivityEvent>();
}
