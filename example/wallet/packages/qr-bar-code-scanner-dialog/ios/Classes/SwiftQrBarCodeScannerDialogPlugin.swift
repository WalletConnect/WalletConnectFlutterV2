import Flutter
import UIKit

public class SwiftQrBarCodeScannerDialogPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "qr_bar_code_scanner_dialog", binaryMessenger: registrar.messenger())
    let instance = SwiftQrBarCodeScannerDialogPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
