import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

class NamespaceUtils {
  /// Checks if the string is a chain
  static bool isValidChainId(String value) {
    if (value.contains(':')) {
      List<String> split = value.split(':');
      return split.length == 2;
    }
    return false;
  }

  /// Checks if the string is an account
  static bool isValidAccount(String value) {
    if (value.contains(':')) {
      List<String> split = value.split(':');
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
      List<String> parts = account.split(':');
      String namespace = parts[0];
      String reference = parts[1];
      return '$namespace:$reference';
    }
    return account;
  }

  /// Gets all unique chains from the provided list of accounts
  /// This function assumes that all accounts are valid
  static List<String> getChainsFromAccounts(List<String> accounts) {
    Set<String> chains = {};
    for (var account in accounts) {
      chains.add(
        getChainFromAccount(
          account,
        ),
      );
    }

    return chains.toList();
  }

  /// Gets the namespace string id from the chainId
  /// If the chain id is not valid, then it returns the chain id
  static String getNamespaceFromChain(String chainId) {
    if (isValidChainId(chainId)) {
      return chainId.split(':')[0];
    }
    return chainId;
  }

  /// Gets all unique namespaces from the provided list of accounts
  /// This function assumes that all accounts are valid
  static Map<String, Namespace> getNamespacesFromAccounts(
    List<String> accounts,
  ) {
    Map<String, Namespace> namespaces = {};
    for (var account in accounts) {
      final ns = account.split(':')[0];
      final cid = account.split(':')[1];
      if (namespaces[ns] == null) {
        namespaces[ns] = Namespace(
          accounts: [],
          methods: [],
          events: [],
        );
      }
      namespaces[ns] = namespaces[ns]!.copyWith(
        accounts: [
          ...namespaces[ns]!.accounts,
          account,
        ],
        chains: [
          ...(namespaces[ns]?.chains ?? []),
          '$ns:$cid',
        ],
      );
    }

    return namespaces;
  }

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

  /// Gets the optional methods from a namespace map for the given chain
  static List<String> getOptionalMethodsForChainId({
    required String chainId,
    required Map<String, RequiredNamespace> optionalNamespaces,
  }) {
    List<String> methods = [];
    optionalNamespaces.forEach((String nsOrChain, RequiredNamespace rns) {
      if (nsOrChain == chainId) {
        methods.addAll(rns.methods);
      } else {
        if ((rns.chains ?? []).contains('$nsOrChain:$chainId')) {
          methods.addAll(rns.methods);
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
    if (isValidChainId(nsOrChainId)) {
      chains.add(nsOrChainId);
    } else if (requiredNamespace.chains != null) {
      // We are assuming that the namespace is a chain
      // Validate the requiredNamespace before it is sent here
      chains.addAll(requiredNamespace.chains!);
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
    final Map<String, Namespace> namespaces = _constructNamespaces(
      availableAccounts: availableAccounts,
      availableMethods: availableMethods,
      availableEvents: availableEvents,
      namespacesMap: requiredNamespaces,
    );
    final Map<String, Namespace> optionals = _constructNamespaces(
      availableAccounts: availableAccounts,
      availableMethods: availableMethods,
      availableEvents: availableEvents,
      namespacesMap: optionalNamespaces ?? {},
    );

    // Loop through the optional keys and if they exist in the namespaces, then merge them and delete them from optional
    List<String> keys = optionals.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      String key = keys[i];
      if (namespaces.containsKey(key)) {
        namespaces[key] = Namespace(
          accounts: namespaces[key]!
              .accounts
              .toSet()
              .union(optionals[key]!.accounts.toSet())
              .toList(),
          methods: namespaces[key]!
              .methods
              .toSet()
              .union(optionals[key]!.methods.toSet())
              .toList(),
          events: namespaces[key]!
              .events
              .toSet()
              .union(optionals[key]!.events.toSet())
              .toList(),
        );
        optionals.remove(key);
      }
    }

    return {
      ...namespaces,
      ...optionals,
    };
  }

  static Map<String, Namespace> buildNamespacesFromAuth({
    required Set<String> methods,
    required Set<String> accounts,
  }) {
    final parsedAccounts = accounts.map(
      (account) => account.replaceAll('did:pkh:', ''),
    );

    final namespaces = getNamespacesFromAccounts(parsedAccounts.toList());

    final entries = namespaces.entries.map((e) {
      return MapEntry(
        e.key,
        Namespace.fromJson(e.value.toJson()).copyWith(
          methods: methods.toList(),
          events: EventsConstants.allEvents,
        ),
      );
    });

    return Map<String, Namespace>.fromEntries(entries);
  }

  /// Gets the matching items from the available items using the chainId
  /// This function assumes that each element in the available items is in the format of chainId:itemId
  static Set<String> _getMatching({
    required String namespaceOrChainId,
    required Set<String> available,
    Set<String>? requested,
    bool takeLast = true,
  }) {
    Set<String> matching = {};
    // Loop through the available items, and if it starts with the chainId,
    // and is in the requested items, add it to the matching items
    for (var item in available) {
      if (item.startsWith('$namespaceOrChainId:')) {
        matching.add(takeLast ? item.split(':').last : item);
      }
    }

    if (requested != null) {
      matching = matching.intersection(requested);
    }

    return matching;
  }

  static Map<String, Namespace> _constructNamespaces({
    required Set<String> availableAccounts,
    required Set<String> availableMethods,
    required Set<String> availableEvents,
    required Map<String, RequiredNamespace> namespacesMap,
  }) {
    Map<String, Namespace> namespaces = {};

    // Loop through the required namespaces
    for (final String namespaceOrChainId in namespacesMap.keys) {
      // If the key is a chain, add all of the chain specific events, keys, and methods first
      final List<String> accounts = [];
      final List<String> events = [];
      final List<String> methods = [];
      final namespace = namespacesMap[namespaceOrChainId]!;
      final chains = namespace.chains ?? [];
      if (NamespaceUtils.isValidChainId(namespaceOrChainId) || chains.isEmpty) {
        // Add the chain specific availableAccounts
        accounts.addAll(
          _getMatching(
            namespaceOrChainId: namespaceOrChainId,
            available: availableAccounts,
            takeLast: false,
          ),
        );
        // Add the chain specific events
        events.addAll(
          _getMatching(
            namespaceOrChainId: namespaceOrChainId,
            available: availableEvents,
            requested: namespace.events.toSet(),
          ),
        );
        // Add the chain specific methods
        methods.addAll(
          _getMatching(
            namespaceOrChainId: namespaceOrChainId,
            available: availableMethods,
            requested: namespace.methods.toSet(),
          ),
        );
      } else {
        // Loop through all of the chains
        for (final String chainId in chains) {
          // Add the chain specific availableAccounts
          accounts.addAll(
            _getMatching(
              namespaceOrChainId: chainId,
              available: availableAccounts,
            ).map((e) => '$chainId:$e'),
          );
          // Add the chain specific events
          events.addAll(
            _getMatching(
              namespaceOrChainId: chainId,
              available: availableEvents,
              requested: namespace.events.toSet(),
            ),
          );
          // Add the chain specific methods
          methods.addAll(
            _getMatching(
              namespaceOrChainId: chainId,
              available: availableMethods,
              requested: namespace.methods.toSet(),
            ),
          );
        }
      }

      // Add the namespace to the list
      namespaces[namespaceOrChainId] = Namespace(
        accounts: accounts.toSet().toList(),
        events: events.toSet().toList(),
        methods: methods.toSet().toList(),
      );
    }

    return namespaces;
  }

  /// To be used by Wallet to regenerate already generatedNamespaces but adding `chains` parameter
  ///
  /// Example usage on onSessionProposal(SessionProposalEvent? event)
  ///
  /// await _web3Wallet!.approveSession(
  ///   id: event.id,
  ///   namespaces: NamespaceUtils.regenerateNamespacesWithChains(
  ///     event.params.generatedNamespaces!,
  ///   ),
  ///   sessionProperties: event.params.sessionProperties,
  /// );

  static Map<String, Namespace> regenerateNamespacesWithChains(
    Map<String, Namespace> generatedNamespaces,
  ) {
    Map<String, Namespace> regeneratedNamespaces = {};
    for (var key in generatedNamespaces.keys) {
      final namespace = generatedNamespaces[key]!.copyWith(
        chains: getChainsFromAccounts(generatedNamespaces[key]!.accounts),
      );
      regeneratedNamespaces[key] = namespace;
    }
    return regeneratedNamespaces;
  }
}
