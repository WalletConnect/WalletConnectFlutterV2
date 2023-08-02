import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/namespace_utils.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';

class SignApiValidatorUtils {
  static bool isContainedIn({
    required List<dynamic> container,
    required List<dynamic> contained,
  }) {
    List<dynamic> matches = contained
        .where(
          (x) => container.contains(x),
        )
        .toList();
    return matches.length == contained.length;
  }

  /// This function will throw an error if
  /// 1. the nsOrChainId parameter is a chainId, and the chains param exists
  /// 2. The list of chains contains an invalid chainId
  static bool isValidChains({
    required String nsOrChainId,
    List<String>? chains,
    required String context,
  }) {
    // If the key is a valid chain Id, then the chains should be empty
    final bool isChainId = NamespaceUtils.isValidChainId(nsOrChainId);
    if (isChainId) {
      if (chains != null && chains.isNotEmpty) {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_CHAINS,
          context: '$context, namespace is a chainId, but chains is not empty',
        );
      }
    } else {
      for (String c in chains!) {
        if (!NamespaceUtils.isValidChainId(c)) {
          throw Errors.getSdkError(
            Errors.UNSUPPORTED_CHAINS,
            context:
                '$context, chain $c should conform to "namespace:chainId" format',
          );
        }
      }
    }

    return true;
  }

  /// Validates the data of the Required Namespaces, ensuring it conforms to CAIP-25
  static bool isValidRequiredNamespaces({
    required Map<String, RequiredNamespace> requiredNamespaces,
    required String context,
  }) {
    requiredNamespaces.forEach((key, namespace) {
      isValidChains(
        nsOrChainId: key,
        chains: namespace.chains,
        context: '$context requiredNamespace',
      );
    });

    return true;
  }

  /// Loops through each account, and validates it
  /// Context is used to provide more information in the error message
  static bool isValidAccounts({
    required List<String> accounts,
    required String context,
  }) {
    for (String account in accounts) {
      if (!NamespaceUtils.isValidAccount(account)) {
        throw Errors.getSdkError(
          Errors.UNSUPPORTED_ACCOUNTS,
          context:
              '$context, account $account should conform to "namespace:chainId:address" format',
        );
      }
    }

    return true;
  }

  /// Validates the data of the Namespaces, ensuring it conforms to CAIP-25
  static bool isValidNamespaces({
    required Map<String, Namespace> namespaces,
    required String context,
  }) {
    namespaces.forEach((key, namespace) {
      isValidAccounts(
        accounts: namespace.accounts,
        context: '$context namespace',
      );
    });

    return true;
  }

  /// Validates the provided chainId, then ensures that the chainId is contained
  /// in the namespaces
  static bool isValidNamespacesChainId({
    required Map<String, Namespace> namespaces,
    required String chainId,
  }) {
    // Validate the chainId
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chain $chainId should conform to "namespace:chainId" format',
      );
    }

    // Validate the namespaces
    isValidNamespaces(
      namespaces: namespaces,
      context: 'isValidNamespacesChainId',
    );

    // Get the chains from the namespaces and
    List<String> chains = NamespaceUtils.getChainIdsFromNamespaces(
      namespaces: namespaces,
    );

    if (!chains.contains(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'The chain $chainId is not supported',
      );
    }

    return true;
  }

  /// Validates the provided chainId, then gets the methods for that chainId
  /// and ensures that the method request is contained in the methods
  static bool isValidNamespacesRequest({
    required Map<String, Namespace> namespaces,
    required String chainId,
    required String method,
  }) {
    // Validate the chainId
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chain $chainId should conform to "namespace:chainId" format',
      );
    }

    // Validate the namespaces
    isValidNamespaces(
      namespaces: namespaces,
      context: 'isValidNamespacesRequest',
    );

    List<dynamic> methods = NamespaceUtils.getNamespacesMethodsForChainId(
      namespaces: namespaces,
      chainId: chainId,
    );

    if (!methods.contains(method)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_METHODS,
        context: 'The method $method is not supported',
      );
    }

    return true;
  }

  /// Validates the provided chainId, then gets the events for that chainId
  /// and ensures that the event request is contained in the events
  static bool isValidNamespacesEvent({
    required Map<String, Namespace> namespaces,
    required String chainId,
    required String eventName,
  }) {
    // Validate the chainId
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chain $chainId should conform to "namespace:chainId" format',
      );
    }

    // Validate the namespaces
    isValidNamespaces(
      namespaces: namespaces,
      context: 'isValidNamespacesEvent',
    );

    List<dynamic> events = NamespaceUtils.getNamespacesEventsForChain(
      namespaces: namespaces,
      chainId: chainId,
    );

    if (!events.contains(eventName)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_EVENTS,
        context: 'The event $eventName is not supported',
      );
    }

    return true;
  }

  /// Makes sure that the chains, methods and events of the required namespaces
  /// are contained in the namespaces
  static bool isConformingNamespaces({
    required Map<String, RequiredNamespace> requiredNamespaces,
    required Map<String, Namespace> namespaces,
    required String context,
  }) {
    List<String> requiredNamespaceKeys = requiredNamespaces.keys.toList();
    List<String> namespaceKeys = namespaces.keys.toList();

    // If the namespaces doesn't have the correct keys, we can fail automatically
    if (!isContainedIn(
        container: namespaceKeys, contained: requiredNamespaceKeys)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_NAMESPACE_KEY,
        context: "$context namespaces keys don't satisfy requiredNamespaces",
      );
    } else {
      for (var key in requiredNamespaceKeys) {
        List<String> requiredNamespaceChains =
            NamespaceUtils.getChainsFromRequiredNamespace(
          nsOrChainId: key,
          requiredNamespace: requiredNamespaces[key]!,
        );
        List<String> namespaceChains = NamespaceUtils.getChainIdsFromNamespace(
          nsOrChainId: key,
          namespace: namespaces[key]!,
        );

        // Check the chains, methods and events for overlaps.
        // If any of them don't have it, we fail.
        final bool chainsOverlap = isContainedIn(
          container: namespaceChains,
          contained: requiredNamespaceChains,
        );
        final bool methodsOverlap = isContainedIn(
          container: namespaces[key]!.methods,
          contained: requiredNamespaces[key]!.methods,
        );
        final bool eventsOverlap = isContainedIn(
          container: namespaces[key]!.events,
          contained: requiredNamespaces[key]!.events,
        );

        if (!chainsOverlap) {
          throw Errors.getSdkError(
            Errors.UNSUPPORTED_CHAINS,
            context:
                "$context namespaces chains don't satisfy requiredNamespaces chains for $key. Requested: $requiredNamespaceChains, Supported: $namespaceChains",
          );
        } else if (!methodsOverlap) {
          throw Errors.getSdkError(
            Errors.UNSUPPORTED_METHODS,
            context:
                "$context namespaces methods don't satisfy requiredNamespaces methods for $key. Requested: ${requiredNamespaces[key]!.methods}, Supported: ${namespaces[key]!.methods}",
          );
        } else if (!eventsOverlap) {
          throw Errors.getSdkError(
            Errors.UNSUPPORTED_EVENTS,
            context:
                "$context namespaces events don't satisfy requiredNamespaces events for $key. Requested: ${requiredNamespaces[key]!.events}, Supported: ${namespaces[key]!.events}",
          );
        }
      }
    }

    return true;
  }

  static bool isSessionCompatible({
    required SessionData session,
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    List<String> sessionKeys = session.namespaces.keys.toList();
    List<String> paramsKeys = requiredNamespaces.keys.toList();
    bool compatible = true;

    if (!isContainedIn(container: sessionKeys, contained: paramsKeys)) {
      return false;
    }

    for (var key in sessionKeys) {
      Namespace namespace = session.namespaces[key]!;
      RequiredNamespace requiredNamespace = requiredNamespaces[key]!;
      List<String> requiredNamespaceChains =
          NamespaceUtils.getChainsFromRequiredNamespace(
        nsOrChainId: key,
        requiredNamespace: requiredNamespace,
      );
      List<String> namespaceChains = NamespaceUtils.getChainIdsFromNamespace(
        nsOrChainId: key,
        namespace: namespace,
      );

      // Check the chains, methods and events for overlaps.
      // If any of them don't have it, we fail.
      final bool chainsOverlap = isContainedIn(
        container: namespaceChains,
        contained: requiredNamespaceChains,
      );
      final bool methodsOverlap = isContainedIn(
        container: namespace.methods,
        contained: requiredNamespaces[key]!.methods,
      );
      final bool eventsOverlap = isContainedIn(
        container: namespace.events,
        contained: requiredNamespaces[key]!.events,
      );

      if (!chainsOverlap || !methodsOverlap || !eventsOverlap) {
        compatible = false;
      }
    }

    return compatible;
  }
}
