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
        color: Colors.black12,
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
        if (model.title != null)
          Text(
            model.title!,
            style: StyleConstants.layerTextStyle3,
          ),
        if (model.title != null) const SizedBox(height: StyleConstants.linear8),
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
    return ElevatedButton(
      onPressed:
          model.elementActions != null ? model.elementActions![text] : null,
      style: ButtonStyle(
        elevation: model.elementActions != null
            ? MaterialStateProperty.all(4.0)
            : MaterialStateProperty.all(0.0),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0.0)),
        visualDensity: VisualDensity.compact,
        backgroundColor: MaterialStateProperty.all(
          StyleConstants.layerColor4,
        ),
        overlayColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(StyleConstants.linear16),
            );
          },
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(
          StyleConstants.linear8,
        ),
        child: Text(
          text,
          style: StyleConstants.layerTextStyle4,
        ),
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
