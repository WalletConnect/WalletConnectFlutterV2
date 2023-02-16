import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

class NamespaceUtils {
  /// Checks if the string is a chainId
  static bool isValidChainId(String value) {
    if (value.contains(":")) {
      List<String> split = value.split(":");
      return split.length == 2;
    }
    return false;
  }

  /// Checks if the string is an account
  static bool isValidAccount(String value) {
    if (value.contains(":")) {
      List<String> split = value.split(":");
      if (split.length == 3) {
        String chainId = split[0] + ":" + split[1];
        return split.length >= 2 && isValidChainId(chainId);
      }
    }
    return false;
  }

  static bool isValidUrl(String value) {
    try {
      Uri.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Gets all unique chainIds from the provided list of accounts
  /// This function assumes that all accounts are valid
  static List<String> getChainsFromAccounts(List<String> accounts) {
    Set<String> chains = {};
    accounts.forEach((account) {
      List<String> parts = account.split(":");
      String chain = parts[0];
      String chainId = parts[1];
      chains.add("$chain:$chainId");
    });

    return chains.toList();
  }

  /// Gets the chainIds from the namespace.
  /// If the namespace is a chainId, then it returns the chainId.
  /// Otherwise it gets the chains from the accounts in the namespace.
  static List<String> getChainsFromNamespace({
    required String nsOrChainId,
    required Namespace namespace,
  }) {
    if (isValidChainId(nsOrChainId)) {
      return [nsOrChainId];
    }

    return getChainsFromAccounts(namespace.accounts);
  }

  /// Gets the chainIds from the namespace.

  static List<String> getChainsFromNamespaces({
    required Map<String, Namespace> namespaces,
  }) {
    Set<String> chains = {};

    namespaces.forEach((String ns, Namespace namespace) {
      chains.addAll(
        getChainsFromNamespace(
          nsOrChainId: ns,
          namespace: namespace,
        ),
      );
    });

    return chains.toList();
  }

  /// Gets the methods from a namespace map for the given chainId
  static List<String> getNamespacesMethodsForChainId({
    required String chainId,
    required Map<String, Namespace> namespaces,
  }) {
    List<String> methods = [];
    namespaces.forEach((String nsOrChainId, Namespace namespace) {
      if (nsOrChainId == chainId) {
        methods.addAll(namespace.methods);
      } else {
        List<String> chains = getChainsFromAccounts(namespace.accounts);
        if (chains.contains(chainId)) {
          methods.addAll(namespace.methods);
        }
      }
    });

    return methods;
  }

  /// Gets the methods from a namespace map for the given chainId
  static List<String> getNamespacesEventsForChainId({
    required String chainId,
    required Map<String, Namespace> namespaces,
  }) {
    List<String> events = [];
    namespaces.forEach((String nsOrChainId, Namespace namespace) {
      if (nsOrChainId == chainId) {
        events.addAll(namespace.events);
      } else {
        List<String> chains = getChainsFromAccounts(namespace.accounts);
        if (chains.contains(chainId)) {
          events.addAll(namespace.events);
        }
      }
    });

    return events;
  }

  /// If the namespace is a chainId, add it to the list and return it
  /// Otherwise, get the chainIds from the required namespaces
  static List<String> getChainsFromRequiredNamespace({
    required String nsOrChainId,
    required RequiredNamespace requiredNamespace,
  }) {
    List<String> chains = [];
    if (requiredNamespace.chains != null) {
      chains.addAll(requiredNamespace.chains!);
    } else {
      // We are assuming that the namespace is a chainId
      // Validate the requiredNamespace before it is sent here
      chains.add(nsOrChainId);
    }

    return chains;
  }

  /// Gets the chainIds from the required namespaces
  /// If keys value is provided, it will only get the chainIds for the provided keys
  static List<String> getChainsFromRequiredNamespaces({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    Set<String> chains = {};

    // Loop through the required namespaces
    requiredNamespaces.forEach((String ns, RequiredNamespace value) {
      chains.addAll(
        getChainsFromRequiredNamespace(
          nsOrChainId: ns,
          requiredNamespace: value,
        ),
      );
    });

    return chains.toList();
  }
}
