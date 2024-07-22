import 'qr_bar_code_scanner_dialog_platform_interface.dart';

import 'package:flutter/widgets.dart';

class QrBarCodeScannerDialog {
  Future<String?> getPlatformVersion() {
    return QrBarCodeScannerDialogPlatform.instance.getPlatformVersion();
  }

  void getScannedQrBarCode(
      {BuildContext? context, required Function(String?) onCode}) {
    QrBarCodeScannerDialogPlatform.instance
        .scanBarOrQrCode(context: context, onScanSuccess: onCode);
  }
}
