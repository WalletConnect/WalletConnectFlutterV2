import 'package:event/event.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/i_auth_engine_app.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/i_auth_engine_wallet.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/models/auth_client_models.dart';

abstract class IAuthEngine implements IAuthEngineWallet, IAuthEngineApp {}
