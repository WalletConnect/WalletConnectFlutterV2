import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';

class QRScanSheet extends StatelessWidget {
  QRScanSheet({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            StyleConstants.magic20,
          ),
          topRight: Radius.circular(
            StyleConstants.magic20,
          ),
        ),
      ),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: StyleConstants.magic40,
              child: Text(
                title,
                style: StyleConstants.titleText,
              ),
            ),
            Positioned(
              top: StyleConstants.magic40,
              right: StyleConstants.magic40,
              child: Container(
                width: StyleConstants.magic40,
                height: StyleConstants.magic40,
                decoration: const BoxDecoration(
                  color: StyleConstants.layerColor0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      StyleConstants.magic20,
                    ),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: StyleConstants.primaryColor,
                  ),
                  iconSize: StyleConstants.magic40,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Center(
              child: MobileScanner(
                controller: controller,
                onDetect: (barcode) async {
                  // If the barcode has a value, return it and pop the sheet
                  if (barcode.barcodes.isNotEmpty &&
                      barcode.barcodes.first.rawValue != null) {
                    Navigator.of(context).pop(barcode.barcodes.first.rawValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
