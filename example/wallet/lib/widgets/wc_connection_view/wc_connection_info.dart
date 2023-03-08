import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_view/wc_connection_model.dart';

class WCConnectionInfo extends StatelessWidget {
  const WCConnectionInfo({
    Key? key,
    required this.model,
  }) : super(key: key);

  final WCConnectionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      decoration: BoxDecoration(
        color: StyleConstants.layerColor3,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear8,
        ),
      ),
      child: model.elements != null ? _buildList() : _buildText(),
    );
  }

  Widget _buildList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title!,
          style: StyleConstants.layerTextStyle3,
        ),
        const SizedBox(height: 8),
        Flex(
          direction: Axis.horizontal,
          children: model.elements!.map((e) => _buildElement(e)).toList(),
        ),
      ],
    );
  }

  Widget _buildElement(String text) {
    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.layerColor4,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear8,
        ),
      ),
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      child: Text(
        text,
        style: StyleConstants.layerTextStyle4,
      ),
    );
  }

  Widget _buildText() {
    return Text(
      model.text!,
      style: StyleConstants.layerTextStyle3,
    );
  }
}
