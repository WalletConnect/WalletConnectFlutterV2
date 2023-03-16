import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';

class UriInputPopup extends StatelessWidget {
  UriInputPopup({
    Key? key,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: StyleConstants.layerColor1NoAlpha,
      title: const Text(
        StringConstants.enterUri,
        style: StyleConstants.subtitleText,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - StyleConstants.linear8,
        // height: 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              StringConstants.enterUriMessage,
              style: StyleConstants.layerTextStyle3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: StyleConstants.magic10,
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintStyle: StyleConstants.layerTextStyle3,
                hintText: StringConstants.textFieldPlaceholder,
                fillColor: StyleConstants.layerColor2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      StyleConstants.magic10,
                    ),
                  ),
                ),
              ),
              autofocus: true,
            ),
            MaterialButton(
              child: const Text(
                StringConstants.connect,
                style: StyleConstants.buttonText,
              ),
              onPressed: () {
                Navigator.of(context).pop(
                  controller.text,
                );
              },
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                StringConstants.cancel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
