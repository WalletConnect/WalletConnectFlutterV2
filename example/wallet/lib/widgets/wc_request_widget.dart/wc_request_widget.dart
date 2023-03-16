import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(
          height: StyleConstants.linear8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: onAccept ?? () => Navigator.of(context).pop(true),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  StyleConstants.linear8,
                ),
              ),
              highlightColor: StyleConstants.successColor,
              child: const Text(
                StringConstants.reject,
                style: StyleConstants.buttonText,
              ),
            ),
            InkWell(
              onTap: onReject ?? () => Navigator.of(context).pop(false),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  StyleConstants.linear8,
                ),
              ),
              highlightColor: StyleConstants.errorColor,
              child: const Text(
                StringConstants.reject,
                style: StyleConstants.buttonText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
