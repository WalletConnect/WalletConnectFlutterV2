import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/custom_button.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_connection_request_widget.dart';

class WCRequestWidget extends StatelessWidget {
  const WCRequestWidget({
    super.key,
    required this.child,
    this.verifyContext,
    this.onAccept,
    this.onReject,
  });

  final Widget child;
  final VerifyContext? verifyContext;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VerifyContextWidget(
          verifyContext: verifyContext,
        ),
        Flexible(
          child: SingleChildScrollView(
            child: child,
          ),
        ),
        const SizedBox(height: StyleConstants.linear16),
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
    );
  }
}
