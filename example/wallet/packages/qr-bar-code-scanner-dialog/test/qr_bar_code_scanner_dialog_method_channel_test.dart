// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog_method_channel.dart';

void main() {
  MethodChannelQrBarCodeScannerDialog platform =
      MethodChannelQrBarCodeScannerDialog();
  const MethodChannel channel = MethodChannel('qr_bar_code_scanner_dialog');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
