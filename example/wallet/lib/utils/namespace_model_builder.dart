import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';

class ConnectionWidgetBuilder {
  static List<WCConnectionWidget> buildFromRequiredNamespaces(
    Map<String, Namespace> generatedNamespaces,
  ) {
    final List<WCConnectionWidget> views = [];
    for (final key in generatedNamespaces.keys) {
      final namespaces = generatedNamespaces[key]!;
      final chains = NamespaceUtils.getChainsFromAccounts(namespaces.accounts);
      final List<WCConnectionModel> models = [];
      // If the chains property is present, add the chain data to the models
      models.add(
        WCConnectionModel(
          title: StringConstants.chains,
          elements: chains,
        ),
      );
      models.add(
        WCConnectionModel(
          title: StringConstants.methods,
          elements: namespaces.methods,
        ),
      );
      models.add(
        WCConnectionModel(
          title: StringConstants.events,
          elements: namespaces.events,
        ),
      );

      views.add(
        WCConnectionWidget(
          title: key,
          info: models,
        ),
      );
    }

    return views;
  }

  static List<WCConnectionWidget> buildFromNamespaces(
    String topic,
    Map<String, Namespace> namespaces,
  ) {
    final List<WCConnectionWidget> views = [];
    for (final key in namespaces.keys) {
      final ns = namespaces[key]!;
      final List<WCConnectionModel> models = [];
      // If the chains property is present, add the chain data to the models
      models.add(
        WCConnectionModel(
          title: StringConstants.accounts,
          elements: ns.accounts,
        ),
      );
      models.add(
        WCConnectionModel(
          title: StringConstants.methods,
          elements: ns.methods,
        ),
      );

      Map<String, void Function()> actions = {};
      for (final String event in ns.events) {
        actions[event] = () async {
          final String chainId = NamespaceUtils.isValidChainId(key)
              ? key
              : NamespaceUtils.getChainFromAccount(ns.accounts.first);
          await GetIt.I<IWeb3WalletService>().getWeb3Wallet().emitSessionEvent(
                topic: topic,
                chainId: chainId,
                event: SessionEventParams(
                  name: event,
                  data: 'Event: $event',
                ),
              );
        };
      }
      models.add(
        WCConnectionModel(
          title: '${StringConstants.events} (Tap to send)',
          elements: ns.events,
          elementActions: actions,
        ),
      );

      views.add(
        WCConnectionWidget(
          title: key,
          info: models,
        ),
      );
    }

    return views;
  }
}
