import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';

class ChainButton extends StatelessWidget {
  const ChainButton({
    super.key,
    required this.chain,
    required this.onPressed,
    this.selected = false,
  });

  final ChainMetadata chain;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: StyleConstants.linear48,
      margin: const EdgeInsets.symmetric(
        vertical: StyleConstants.linear8,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: chain.color,
                width: selected ? 6 : 2,
              ),
              borderRadius: BorderRadius.circular(
                StyleConstants.linear8,
              ),
            ),
          ),
        ),
        child: Text(
          chain.name,
          style: StyleConstants.buttonText,
        ),
      ),
    );
  }
}
