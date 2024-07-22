import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog_platform_interface.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQrBarCodeScannerDialogPlatform
    with MockPlatformInterfaceMixin
    implements QrBarCodeScannerDialogPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void scanBarOrQrCode(
      {BuildContext? context, required Function(String? p1) onScanSuccess}) {
    onScanSuccess("CODE");
  }
}

void main() {
  final QrBarCodeScannerDialogPlatform initialPlatform =
      QrBarCodeScannerDialogPlatform.instance;

  test('$MethodChannelQrBarCodeScannerDialog is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelQrBarCodeScannerDialog>());
  });

  test('getPlatformVersion', () async {
    QrBarCodeScannerDialog qrBarCodeScannerDialogPlugin =
        QrBarCodeScannerDialog();
    MockQrBarCodeScannerDialogPlatform fakePlatform =
        MockQrBarCodeScannerDialogPlatform();
    QrBarCodeScannerDialogPlatform.instance = fakePlatform;

    expect(await qrBarCodeScannerDialogPlugin.getPlatformVersion(), '42');
  });

  test('scanBarOrQrCodeWeb', () async {
    QrBarCodeScannerDialog qrBarCodeScannerDialogPlugin =
        QrBarCodeScannerDialog();
    MockQrBarCodeScannerDialogPlatform fakePlatform =
        MockQrBarCodeScannerDialogPlatform();
    QrBarCodeScannerDialogPlatform.instance = fakePlatform;

    qrBarCodeScannerDialogPlugin.getScannedQrBarCode(onCode: (code) {
      expect(code, 'CODE');
    });
  });
}
