// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html
    show window, Element, ScriptElement, StyleElement, querySelector, Text;

import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'qr_bar_code_scanner_dialog_platform_interface.dart';
import 'dart:js' as js;

const String _kQrBarCodeScannerModelDomId = '__qr_bar_code_scanner_web-model';

/// A web implementation of the QrBarCodeScannerDialogPlatform of the QrBarCodeScannerDialog plugin.
class QrBarCodeScannerDialogWeb extends QrBarCodeScannerDialogPlatform {
  /// Constructs a QrBarCodeScannerDialogWeb
  QrBarCodeScannerDialogWeb() {
    _ensureInitialized(_kQrBarCodeScannerModelDomId);
  }

  static void registerWith(Registrar registrar) {
    QrBarCodeScannerDialogPlatform.instance = QrBarCodeScannerDialogWeb();
  }

  /// Initializes a DOM container where we can host input elements.
  html.Element _ensureInitialized(String id) {
    var target = html.querySelector('#$id');
    if (target == null) {
      final html.Element targetElement = html.Element.div()
        ..id = id
        ..className = "modal";

      final html.Element content = html.Element.div()
        ..className = "modal-content";

      final html.Element div = html.Element.div()
        ..setAttribute("style", "container");

      final html.Element reader = html.Element.div()
        ..id = "qr-reader"
        ..setAttribute("width", "400px");
      div.children.add(reader);

      content.children.add(div);
      targetElement.children.add(content);

      final body = html.querySelector('body')!;

      body.children.add(targetElement);

      final script = html.ScriptElement()
        ..src = "https://unpkg.com/html5-qrcode";
      body.children.add(script);

      final head = html.querySelector('head')!;
      final style = html.StyleElement();

      final styleContent = html.Text("""
        
        /* The Modal (background) */
        .modal {
          display: none; /* Hidden by default */
          position: fixed; /* Stay in place */
          z-index: 1; /* Sit on top */
          padding-top: 100px; /* Location of the box */
          left: 0;
          top: 0;
          width: 100%; /* Full width */
          height: 100%; /* Full height */
          overflow: auto; /* Enable scroll if needed */
          background-color: rgb(0,0,0); /* Fallback color */
          background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
        
        /* Modal Content */
        .modal-content {
          margin: auto;
          max-width: 600px;
          border-radius: 10px;
        }
        
        #qr-reader {
          position: relative;
          background: white;
          margin: 25px;
          border-radius: 10px;
          border: none;
        }
        
        #qr-reader__filescan_input,
        #qr-reader__camera_permission_button {
          background: #3b99e8;
          border: none;
          padding: 8px;
          border-radius: 5px;
          color: white;
          cursor:pointer;
          margin-bottom: 10px;
        }
      
      """);

      final codeScript = html.ScriptElement();
      final scriptText = html.Text(r"""
        
        var html5QrcodeScanner;

        // Get the modal
        var modal = document.getElementById("__qr_bar_code_scanner_web-model");
        
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
          if (event.target == modal) {
            modal.style.display = "none";
              if(html5QrcodeScanner!=null)
                html5QrcodeScanner.clear();
          }
        }

        async function scanCode(message) {
        
            html5QrcodeScanner = new Html5QrcodeScanner("qr-reader", { fps: 20, qrbox: 250 });
        
            modal.style.display = "block";
            html5QrcodeScanner.render((decodedText, decodedResult) => {
                console.log(`Code scanned = ${decodedText}`, decodedResult);
                message(`Code scanned = ${decodedText}`);
                html5QrcodeScanner.clear();
                modal.style.display = "none";
            });
        
        
        }
        
      """);
      codeScript.nodes.add(scriptText);

      style.nodes.add(styleContent);
      head.children.add(style);
      head.children.add(codeScript);

      target = targetElement;
    }
    return target;
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

  @override
  void scanBarOrQrCode(
      {BuildContext? context, required Function(String?) onScanSuccess}) {
    js.context.callMethod("scanCode", [onScanSuccess]);
  }
}
