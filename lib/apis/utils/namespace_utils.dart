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
        String chainId = '${split[0]}:${split[1]}';
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

  static String getAccount(String namespaceAccount) {
    if (isValidAccount(namespaceAccount)) {
      return namespaceAccount.split(':')[2];
    }
    return namespaceAccount;
  }

  static String getChainFromAccount(String account) {
    if (isValidAccount(account)) {
      List<String> parts = account.split(":");
      String namespace = parts[0];
      String chainId = parts[1];
      return "$namespace:$chainId";
    }
    return account;
  }

  /// Gets all unique chainIds from the provided list of accounts
  /// This function assumes that all accounts are valid
  static List<String> getChainsFromAccounts(List<String> accounts) {
    Set<String> chains = {};
    accounts.forEach((account) {
      chains.add(
        getChainFromAccount(
          account,
        ),
      );
    });

    return chains.toList();
  }

  /// Gets the namespace string id from the chainId
  /// If the chainId is not valid, then it returns the chain
  static String getNamespaceFromChain(String chain) {
    if (isValidChainId(chain)) {
      return chain.split(":")[0];
    }
    return chain;
  }

  /// Gets all unique namespaces from the provided list of accounts
  /// This function assumes that all accounts are valid
  // static List<String> getNamespacesFromAccounts(List<String> accounts) {
  //   Set<String> namespaces = {};
  //   accounts.forEach((account) {
  //     chains.add(
  //       getChainFromAccount(
  //         account,
  //       ),
  //     );
  //   });

  //   return chains.toList();
  // }

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

  /// Using the availabe accounts, methods, and events, construct the namespaces
  /// If optional namespaces are provided, then they will be added to the namespaces as well
  static Map<String, Namespace> constructNamespaces({
    required Map<String, Set<String>> availableAccounts,
    required List<String> availableMethods,
    required Map<String, Set<String>> availableEvents,
    required Map<String, RequiredNamespace> requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
  }) {
    return {
      ..._constructNamespacesFromRequired(
        availableAccounts: availableAccounts,
        availableMethods: availableMethods,
        availableEvents: availableEvents,
        requiredNamespaces: requiredNamespaces,
      ),
      ...optionalNamespaces == null
          ? {}
          : _constructNamespacesFromRequired(
              availableAccounts: availableAccounts,
              availableMethods: availableMethods,
              availableEvents: availableEvents,
              requiredNamespaces: optionalNamespaces,
            )
    };
  }

  static Map<String, Namespace> _constructNamespacesFromRequired({
    required Map<String, Set<String>> availableAccounts,
    required List<String> availableMethods,
    required Map<String, Set<String>> availableEvents,
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    Map<String, Namespace> namespaces = {};

    // Loop through the required namespaces
    for (final String namespaceOrChainId in requiredNamespaces.keys) {
      // If the key is a chainId, add all of the chain specific events, keys, and methods first
      final List<String> accounts = [];
      final List<String> events = [];
      final List<String> methods = [];

      String namespace = namespaceOrChainId;
      if (NamespaceUtils.isValidChainId(namespaceOrChainId)) {
        namespace = NamespaceUtils.getNamespaceFromChain(namespaceOrChainId);

        // Add the chain specific availableAccounts
        if (availableAccounts[namespaceOrChainId] != null) {
          accounts.addAll(availableAccounts[namespaceOrChainId]!);
        }
        // Add the chain specific functions
        // Loop through all method handlers
        for (final String method in availableMethods) {
          // If the method is a chain specific method, add it to the list
          if (method.startsWith(namespaceOrChainId)) {
            methods.add(method.split(':').last);
          }
        }
        // Add the chain specific events
        if (availableEvents[namespaceOrChainId] != null) {
          events.addAll(availableEvents[namespaceOrChainId]!);
        }
      } else {
        // Add the namespace specific availableAccounts
        if (availableAccounts[namespace] != null) {
          accounts.addAll(availableAccounts[namespace]!);
        }

        // Add the namespace specific functions
        List<Set<String>> chainMethodSets = [];
        // Loop through all of the chainIds
        // print(requiredNamespaces[namespaceOrChainId]!);
        // print(requiredNamespaces[namespaceOrChainId]!.chains);
        for (final String chainId
            in requiredNamespaces[namespaceOrChainId]!.chains!) {
          Set<String> chainMethods = {};
          // Loop through all method handlers
          for (final String method in availableMethods) {
            // If the method is a chain specific method, add it to the list
            if (method.startsWith(chainId)) {
              chainMethods.add(method.split(':').last);
            }
          }
          chainMethodSets.add(chainMethods);
        }

        // Get the intersection of the chainMethodSets
        Set<String> intersection = chainMethodSets.first;

        for (final Set<String> chainMethods in chainMethodSets) {
          intersection = intersection.intersection(chainMethods);
        }

        methods.addAll(intersection);

        // Add the namespace specific events
        if (availableEvents[namespace] != null) {
          events.addAll(availableEvents[namespace]!);
        }
      }

      // Add the namespace to the list
      namespaces[namespaceOrChainId] = Namespace(
        accounts: accounts,
        events: events,
        methods: methods,
      );
    }

    return namespaces;
  }
}
