import 'package:mockito/annotations.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/key_chain/key_chain.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/topic_map.dart';

@GenerateMocks([
  KeyChain,
  CryptoUtils,
  Crypto,
  MessageTracker,
  TopicMap,
])
class SharedTestUtils {}
