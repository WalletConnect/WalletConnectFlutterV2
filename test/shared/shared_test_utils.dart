// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/core/core.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/i_crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/websocket_handler.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

import 'shared_test_utils.mocks.dart';

@GenerateMocks([
  CryptoUtils,
  Crypto,
  MessageTracker,
  HttpWrapper,
  Core,
  WebSocketHandler,
])
class SharedTestUtils {}

ICrypto getCrypto({
  ICore? core,
  MockCryptoUtils? utils,
}) {
  final ICore _core = core ?? Core(projectId: '', memoryStore: true);
  final ICrypto crypto = Crypto(
    core: _core,
    keyChain: GenericStore<String>(
      storage: _core.storage,
      context: StoreVersions.CONTEXT_KEYCHAIN,
      version: StoreVersions.VERSION_KEYCHAIN,
      fromJson: (dynamic value) => value as String,
    ),
    utils: utils,
  );
  _core.crypto = crypto;
  return crypto;
}

IMessageTracker getMessageTracker({
  ICore? core,
}) {
  final ICore _core = core ?? Core(projectId: '', memoryStore: true);
  return MessageTracker(
    storage: _core.storage,
    context: StoreVersions.CONTEXT_MESSAGE_TRACKER,
    version: StoreVersions.VERSION_MESSAGE_TRACKER,
    fromJson: (dynamic value) => WalletConnectUtils.convertMapTo<String>(value),
  );
}

IGenericStore<String> getTopicMap({
  ICore? core,
}) {
  final ICore _core = core ?? Core(projectId: '', memoryStore: true);
  return GenericStore<String>(
    storage: _core.storage,
    context: StoreVersions.CONTEXT_TOPIC_MAP,
    version: StoreVersions.VERSION_TOPIC_MAP,
    fromJson: (dynamic value) => value as String,
  );
}

MockHttpWrapper getHttpWrapper() {
  final MockHttpWrapper httpWrapper = MockHttpWrapper();
  when(httpWrapper.get(any)).thenAnswer((_) async => Response('', 200));
  // when(httpWrapper.post(
  //   url: anyNamed('url'),
  //   body: anyNamed('body'),
  // )).thenAnswer((_) async => '');

  return httpWrapper;
}

mockPackageInfo() {
  PackageInfo.setMockInitialValues(
    appName: _mockInitialValues['appName'],
    packageName: _mockInitialValues['packageName'],
    version: _mockInitialValues['version'],
    buildNumber: _mockInitialValues['buildNumber'],
    buildSignature: _mockInitialValues['buildSignature'],
  );
}

mockConnectivity([List<dynamic> values = const ['wifi']]) {
  const channel = MethodChannel('dev.fluttercommunity.plus/connectivity');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler(
    channel.name,
    (data) async {
      final call = channel.codec.decodeMethodCall(data);
      if (call.method == 'getAll') {
        return channel.codec.encodeSuccessEnvelope(_mockInitialValues);
      }
      if (call.method == 'check') {
        return channel.codec.encodeSuccessEnvelope(values);
      }
      return null;
    },
  );
}

Map<String, dynamic> get _mockInitialValues => {
      'appName': 'walletconnect_flutter_v2',
      'packageName': 'com.walletconnect.flutterdapp',
      'version': '1.0',
      'buildNumber': '2',
      'buildSignature': 'buildSignature',
    };
