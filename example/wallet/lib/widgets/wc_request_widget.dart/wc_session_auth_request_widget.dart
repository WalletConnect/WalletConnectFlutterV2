import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/custom_button.dart';

class WCSessionAuthRequestWidget extends StatelessWidget {
  const WCSessionAuthRequestWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(height: StyleConstants.linear16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onTap: () =>
                    Navigator.of(context).pop(WCBottomSheetResult.reject),
                type: CustomButtonType.invalid,
                child: const Text(
                  'Cancel',
                  style: StyleConstants.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: StyleConstants.linear8),
              CustomButton(
                onTap: () => Navigator.of(context).pop(WCBottomSheetResult.one),
                type: CustomButtonType.normal,
                child: const Text(
                  'Sign One',
                  style: StyleConstants.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: StyleConstants.linear8),
              CustomButton(
                onTap: () => Navigator.of(context).pop(WCBottomSheetResult.all),
                type: CustomButtonType.valid,
                child: const Text(
                  'Sign All',
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
