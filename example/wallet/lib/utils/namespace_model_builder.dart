import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';

class ConnectionWidgetBuilder {
  static List<WCConnectionWidget> buildFromRequiredNamespaces(
    Map<String, RequiredNamespace> requiredNamespaces,
  ) {
    final List<WCConnectionWidget> views = [];
    for (final key in requiredNamespaces.keys) {
      RequiredNamespace ns = requiredNamespaces[key]!;
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

    return views;
  }

  static List<WCConnectionWidget> buildFromNamespaces(
    Map<String, Namespace> namespaces,
  ) {
    final List<WCConnectionWidget> views = [];
    for (final key in namespaces.keys) {
      final Namespace ns = namespaces[key]!;
      final List<WCConnectionModel> models = [];
      // If the chains property is present, add the chain data to the models
      models.add(
        WCConnectionModel(
          title: StringConstants.chains,
          elements: ns.accounts,
        ),
      );
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

    return views;
  }
}
