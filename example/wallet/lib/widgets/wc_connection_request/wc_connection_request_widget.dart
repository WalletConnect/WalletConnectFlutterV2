import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/namespace_model_builder.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_auth_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_session_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';

import '../wc_connection_widget/wc_connection_model.dart';

class WCConnectionRequestWidget extends StatelessWidget {
  const WCConnectionRequestWidget({
    Key? key,
    required this.wallet,
    this.authRequest,
    this.sessionProposal,
  }) : super(key: key);

  final Web3Wallet wallet;
  final WCAuthRequestModel? authRequest;
  final WCSessionRequestModel? sessionProposal;

  @override
  Widget build(BuildContext context) {
    // Get the connection metadata
    final proposerMetadata = sessionProposal?.request.proposer;
    final metadata = authRequest?.request.requester ?? proposerMetadata;

    if (metadata == null) {
      return const Text('ERROR');
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${metadata.metadata.name}\n${StringConstants.wouldLikeToConnect}',
            style: StyleConstants.subtitleText.copyWith(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: StyleConstants.linear8),
          VerifyContextWidget(
            verifyContext: sessionProposal?.verifyContext,
          ),
          const SizedBox(height: StyleConstants.linear8),
          authRequest != null
              ? _buildAuthRequestView()
              : _buildSessionProposalView(context),
        ],
      ),
    );
  }

  Widget _buildAuthRequestView() {
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

  Widget _buildSessionProposalView(BuildContext context) {
    // Create the connection models using the required and optional namespaces provided by the proposal data
    // The key is the title and the list of values is the data
    final views = ConnectionWidgetBuilder.buildFromRequiredNamespaces(
      sessionProposal!.request.generatedNamespaces!,
    );

    return Column(
      children: views,
    );
  }
}

class VerifyContextWidget extends StatelessWidget {
  const VerifyContextWidget({
    super.key,
    required this.verifyContext,
  });
  final VerifyContext? verifyContext;

  @override
  Widget build(BuildContext context) {
    if (verifyContext == null) {
      return const SizedBox.shrink();
    }

    if (verifyContext!.validation.scam) {
      return VerifyBanner(
        color: StyleConstants.errorColor,
        origin: verifyContext!.origin,
        title: 'Security risk',
        text: 'This domain is flagged as unsafe by multiple security providers.'
            ' Leave immediately to protect your assets.',
      );
    }
    if (verifyContext!.validation.invalid) {
      return VerifyBanner(
        color: StyleConstants.errorColor,
        origin: verifyContext!.origin,
        title: 'Domain mismatch',
        text:
            'This website has a domain that does not match the sender of this request.'
            ' Approving may lead to loss of funds.',
      );
    }
    if (verifyContext!.validation.valid) {
      return VerifyHeader(
        iconColor: StyleConstants.successColor,
        title: verifyContext!.origin,
      );
    }
    return VerifyBanner(
      color: Colors.orange,
      origin: verifyContext!.origin,
      title: 'Cannot verify',
      text: 'This domain cannot be verified. '
          'Check the request carefully before approving.',
    );
  }
}

class VerifyHeader extends StatelessWidget {
  const VerifyHeader({
    super.key,
    required this.iconColor,
    required this.title,
  });
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shield_outlined,
          color: iconColor,
        ),
        const SizedBox(width: StyleConstants.linear8),
        Text(
          title,
          style: TextStyle(
            color: iconColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class VerifyBanner extends StatelessWidget {
  const VerifyBanner({
    super.key,
    required this.origin,
    required this.title,
    required this.text,
    required this.color,
  });
  final String origin, title, text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          origin,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox.square(dimension: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            children: [
              VerifyHeader(
                iconColor: color,
                title: title,
              ),
              const SizedBox(height: 4.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
