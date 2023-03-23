import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

class NamespaceUtils {
  /// Checks if the string is a chain
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
      String reference = parts[1];
      return "$namespace:$reference";
    }
    return account;
  }

  /// Gets all unique chains from the provided list of accounts
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
  /// If the chain id is not valid, then it returns the chain id
  static String getNamespaceFromChain(String chainId) {
    if (isValidChainId(chainId)) {
      return chainId.split(":")[0];
    }
    return chainId;
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

  /// Gets the chains from the namespace.
  /// If the namespace is a chain, then it returns the chain.
  /// Otherwise it gets the chains from the accounts in the namespace.
  static List<String> getChainIdsFromNamespace({
    required String nsOrChainId,
    required Namespace namespace,
  }) {
    if (isValidChainId(nsOrChainId)) {
      return [nsOrChainId];
    }

    return getChainsFromAccounts(namespace.accounts);
  }

  /// Gets the chainIds from the namespace.
  static List<String> getChainIdsFromNamespaces({
    required Map<String, Namespace> namespaces,
  }) {
    Set<String> chainIds = {};

    namespaces.forEach((String ns, Namespace namespace) {
      chainIds.addAll(
        getChainIdsFromNamespace(
          nsOrChainId: ns,
          namespace: namespace,
        ),
      );
    });

    return chainIds.toList();
  }

  /// Gets the methods from a namespace map for the given chain
  static List<String> getNamespacesMethodsForChainId({
    required String chainId,
    required Map<String, Namespace> namespaces,
  }) {
    List<String> methods = [];
    namespaces.forEach((String nsOrChain, Namespace namespace) {
      if (nsOrChain == chainId) {
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

  /// Gets the methods from a namespace map for the given chain id
  static List<String> getNamespacesEventsForChain({
    required String chainId,
    required Map<String, Namespace> namespaces,
  }) {
    List<String> events = [];
    namespaces.forEach((String nsOrChain, Namespace namespace) {
      if (nsOrChain == chainId) {
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

  /// If the namespace is a chain, add it to the list and return it
  /// Otherwise, get the chains from the required namespaces
  static List<String> getChainsFromRequiredNamespace({
    required String nsOrChainId,
    required RequiredNamespace requiredNamespace,
  }) {
    List<String> chains = [];
    if (requiredNamespace.chains != null) {
      chains.addAll(requiredNamespace.chains!);
    } else {
      // We are assuming that the namespace is a chain
      // Validate the requiredNamespace before it is sent here
      chains.add(nsOrChainId);
    }

    return chains;
  }

  /// Gets the chains from the required namespaces
  /// If keys value is provided, it will only get the chains for the provided keys
  static List<String> getChainIdsFromRequiredNamespaces({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    Set<String> chainIds = {};

    // Loop through the required namespaces
    requiredNamespaces.forEach((String ns, RequiredNamespace value) {
      chainIds.addAll(
        getChainsFromRequiredNamespace(
          nsOrChainId: ns,
          requiredNamespace: value,
        ),
      );
    });

    return chainIds.toList();
  }

  /// Using the availabe accounts, methods, and events, construct the namespaces
  /// If optional namespaces are provided, then they will be added to the namespaces as well
  static Map<String, Namespace> constructNamespaces({
    required Set<String> availableAccounts,
    required Set<String> availableMethods,
    required Set<String> availableEvents,
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

  /// Gets the matching items from the available items using the chainId
  /// This function assumes that each element in the available items is in the format of chainId:itemId
  static Set<String> _getMatching({
    required String chainId,
    required Set<String> available,
    Set<String>? requested,
    bool takeLast = true,
  }) {
    Set<String> matching = {};
    // Loop through the available items, and if it starts with the chainId,
    // and is in the requested items, add it to the matching items
    available.forEach((item) {
      if (item.startsWith('$chainId:')) {
        matching.add(takeLast ? item.split(':').last : item);
      }
    });

    if (requested != null) {
      matching = matching.intersection(requested);
    }

    return matching;
  }

  static Map<String, Namespace> _constructNamespacesFromRequired({
    required Set<String> availableAccounts,
    required Set<String> availableMethods,
    required Set<String> availableEvents,
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    Map<String, Namespace> namespaces = {};

    // Loop through the required namespaces
    for (final String namespaceOrChainId in requiredNamespaces.keys) {
      // If the key is a chain, add all of the chain specific events, keys, and methods first
      final List<String> accounts = [];
      final List<String> events = [];
      final List<String> methods = [];

      if (NamespaceUtils.isValidChainId(namespaceOrChainId)) {
        // Add the chain specific availableAccounts
        accounts.addAll(
          _getMatching(
            chainId: namespaceOrChainId,
            available: availableAccounts,
            takeLast: false,
          ),
        );
        // Add the chain specific events
        events.addAll(
          _getMatching(
            chainId: namespaceOrChainId,
            available: availableEvents,
            requested: requiredNamespaces[namespaceOrChainId]!.events.toSet(),
          ),
        );
        // Add the chain specific methods
        methods.addAll(
          _getMatching(
            chainId: namespaceOrChainId,
            available: availableMethods,
            requested: requiredNamespaces[namespaceOrChainId]!.methods.toSet(),
          ),
        );
      } else {
        // Add the namespace specific functions
        List<Set<String>> chainMethodSets = [];
        List<Set<String>> chainEventSets = [];
        // Loop through all of the chains
        for (final String chainId
            in requiredNamespaces[namespaceOrChainId]!.chains!) {
          // Add the chain specific availableAccounts
          accounts.addAll(
            _getMatching(
              chainId: chainId,
              available: availableAccounts,
            ).map((e) => '$chainId:$e'),
          );
          // Add the chain specific events
          chainEventSets.add(
            _getMatching(
              chainId: chainId,
              available: availableEvents,
              requested: requiredNamespaces[namespaceOrChainId]!.events.toSet(),
            ),
          );
          // Add the chain specific methods
          chainMethodSets.add(
            _getMatching(
              chainId: chainId,
              available: availableMethods,
              requested:
                  requiredNamespaces[namespaceOrChainId]!.methods.toSet(),
            ),
          );
        }

        // Get the intersection of the chainMethodSets
        Set<String> intersectionMethods = chainMethodSets.first;
        Set<String> intersectionEvents = chainEventSets.first;

        for (final Set<String> chainMethods in chainMethodSets) {
          intersectionMethods = intersectionMethods.intersection(chainMethods);
        }
        for (final Set<String> chainEvents in chainEventSets) {
          intersectionEvents = intersectionEvents.intersection(chainEvents);
        }

        methods.addAll(intersectionMethods);
        events.addAll(intersectionEvents);
      }
      // print(availableAccounts);
      // print(accounts);

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
