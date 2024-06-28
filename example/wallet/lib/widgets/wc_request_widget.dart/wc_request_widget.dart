import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/custom_button.dart';

class WCRequestWidget extends StatelessWidget {
  const WCRequestWidget({
    super.key,
    required this.child,
    this.onAccept,
    this.onReject,
  });

  final Widget child;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

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
                onTap: onReject ??
                    () => Navigator.of(context).pop(WCBottomSheetResult.reject),
                type: CustomButtonType.invalid,
                child: const Text(
                  StringConstants.reject,
                  style: StyleConstants.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: StyleConstants.linear16,
              ),
              CustomButton(
                onTap: onAccept ??
                    () => Navigator.of(context).pop(WCBottomSheetResult.one),
                type: CustomButtonType.valid,
                child: const Text(
                  StringConstants.approve,
                  style: StyleConstants.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
