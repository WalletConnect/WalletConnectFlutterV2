import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/custom_button.dart';

// ignore: must_be_immutable
class WCRequestWidget extends StatelessWidget {
  WCRequestWidget({
    super.key,
    required this.child,
    this.onAccept,
    this.onReject,
  });

  Widget child;
  VoidCallback? onAccept;
  VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(
            height: StyleConstants.linear16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onTap: onAccept ?? () => Navigator.of(context).pop(true),
                type: CustomButtonType.valid,
                child: const Text(
                  StringConstants.approve,
                  style: StyleConstants.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: StyleConstants.linear16,
              ),
              CustomButton(
                onTap: onReject ?? () => Navigator.of(context).pop(false),
                type: CustomButtonType.invalid,
                child: const Text(
                  StringConstants.reject,
                  style: StyleConstants.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          // ),
        ],
      ),
    );
  }
}
