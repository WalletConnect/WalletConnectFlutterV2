import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';

class RecoverFromSeed extends StatelessWidget {
  RecoverFromSeed({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final unfocusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    final focusedBorder = unfocusedBorder.copyWith(
      borderSide: const BorderSide(color: Colors.blue, width: 1.0),
    );
    return Container(
      color: Colors.white,
      height: 282.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Insert Seed Phrase',
            style: StyleConstants.subtitleText.copyWith(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            height: 90.0,
            // padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: controller,
              maxLines: 4,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.blue,
              enableSuggestions: false,
              autocorrect: false,
              cursorHeight: 16.0,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'your seed phrase here',
                hintStyle: const TextStyle(color: Colors.grey),
                border: unfocusedBorder,
                errorBorder: unfocusedBorder,
                enabledBorder: unfocusedBorder,
                disabledBorder: unfocusedBorder,
                focusedBorder: focusedBorder,
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.all(8.0),
              ),
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Recover'),
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
