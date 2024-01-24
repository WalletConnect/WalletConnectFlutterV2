import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

class WCConnectionWidgetInfo extends StatelessWidget {
  const WCConnectionWidgetInfo({
    Key? key,
    required this.model,
  }) : super(key: key);

  final WCConnectionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear16,
        ),
      ),
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      margin: const EdgeInsetsDirectional.only(
        top: StyleConstants.linear8,
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
        const SizedBox(height: StyleConstants.linear8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          direction: Axis.horizontal,
          children: model.elements!.map((e) => _buildElement(e)).toList(),
        ),
      ],
    );
  }

  Widget _buildElement(String text) {
    return InkWell(
      onTap: model.elementActions != null ? model.elementActions![text] : null,
      child: Container(
        decoration: BoxDecoration(
          color: StyleConstants.layerColor4,
          borderRadius: BorderRadius.circular(
            StyleConstants.linear16,
          ),
        ),
        // margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(
          StyleConstants.linear8,
        ),
        child: Text(
          text,
          style: StyleConstants.layerTextStyle4,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      model.text!,
      style: StyleConstants.layerTextStyle3,
      // textAlign: TextAlign.center,
    );
  }
}
