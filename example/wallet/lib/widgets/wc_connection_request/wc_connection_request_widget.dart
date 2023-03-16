import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_auth_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_session_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';

import '../wc_connection_widget/wc_connection_model.dart';

class WCConnectionRequestWidget extends StatelessWidget {
  const WCConnectionRequestWidget({
    Key? key,
    required this.wallet,
    required this.title,
    this.authRequest,
    this.sessionProposal,
  }) : super(key: key);

  final Web3Wallet wallet;
  final String title;
  final WCAuthRequestModel? authRequest;
  final WCSessionRequestModel? sessionProposal;

  @override
  Widget build(BuildContext context) {
    // Get the connection metadata
    final ConnectionMetadata? metadata =
        authRequest?.request.requester ?? sessionProposal?.request.proposer;

    if (metadata == null) {
      return const Text('ERROR');
    }

    return Container(
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      decoration: BoxDecoration(
        color: StyleConstants.layerColor1,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(title),
          const Text(
            StringConstants.wouldLikeToConnect,
            style: StyleConstants.subtitleText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            metadata.metadata.name,
            style: StyleConstants.bodyText,
          ),
          const SizedBox(height: 8),
          authRequest != null ? _buildAuthRequest() : _buildSessionProposal(),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: StyleConstants.titleText,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAuthRequest() {
    final model = WCConnectionModel(
      text: wallet.formatAuthMessage(
        iss: 'did:pkh:eip155:1:${authRequest!.iss}',
        cacaoPayload: CacaoRequestPayload.fromPayloadParams(
          authRequest!.request.payloadParams,
        ),
      ),
    );

    return WCConnectionWidget(
      title: StringConstants.message,
      info: [model],
    );
  }

  Widget _buildSessionProposal() {
    // Create the connection models using the required and optional namespaces provided by the proposal data
    // The key is the title and the list of values is the data
    final List<WCConnectionWidget> views = [];
    for (final key in sessionProposal!.request.requiredNamespaces.keys) {
      RequiredNamespace ns = sessionProposal!.request.requiredNamespaces[key]!;
      final List<WCConnectionModel> models = [];
      // If the chains property is present, add the chain data to the models
      if (ns.chains != null) {
        models.add(
          WCConnectionModel(
            title: StringConstants.chains,
            elements: ns.chains!,
          ),
        );
      }
      models.add(WCConnectionModel(
        title: StringConstants.methods,
        elements: ns.methods,
      ));
      models.add(WCConnectionModel(
        title: StringConstants.events,
        elements: ns.events,
      ));

      views.add(
        WCConnectionWidget(
          title: key,
          info: models,
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) => views[index],
      separatorBuilder: (context, index) => const SizedBox(
        height: StyleConstants.linear8,
      ),
      itemCount: views.length,
    );
  }

  Widget _buildButton(
    String text,
    VoidCallback onPressed, {
    bool isPrimary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      // style: ButtonStyle(),
      child: Text(
        text,
        style: StyleConstants.buttonText,
      ),
    );
  }
}
