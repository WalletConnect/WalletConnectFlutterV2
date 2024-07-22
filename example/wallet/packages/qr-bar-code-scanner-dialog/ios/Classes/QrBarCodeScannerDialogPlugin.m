#import "QrBarCodeScannerDialogPlugin.h"
#if __has_include(<qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog-Swift.h>)
#import <qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qr_bar_code_scanner_dialog-Swift.h"
#endif

@implementation QrBarCodeScannerDialogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQrBarCodeScannerDialogPlugin registerWithRegistrar:registrar];
}
@end
