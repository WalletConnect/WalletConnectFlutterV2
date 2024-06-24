import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';

enum CustomButtonType { normal, valid, invalid }

class CustomButton extends StatelessWidget {
  final Widget child;
  final CustomButtonType? type;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.child,
    required this.onTap,
    this.type,
  });

  Color _getBackgroundColor(CustomButtonType? type) {
    switch (type) {
      case CustomButtonType.normal:
        return Colors.blue;
      case CustomButtonType.valid:
        return StyleConstants.successColor;
      case CustomButtonType.invalid:
        return StyleConstants.errorColor;
      default:
        return Colors.blue[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(type),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          child: child,
        ),
      ),
    );
  }
}
