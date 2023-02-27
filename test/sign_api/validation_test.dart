import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2/apis/utils/namespace_utils.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/sign_api_validator_utils.dart';

import '../shared/shared_test_values.dart';
import 'utils/sign_client_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NamespaceUtils', () {
    test('isValidChainId', () {
      expect(
        NamespaceUtils.isValidChainId(TEST_ETHEREUM_CHAIN),
        true,
      );
      expect(NamespaceUtils.isValidChainId(TEST_CHAIN_INVALID_1), false);
      expect(NamespaceUtils.isValidChainId(TEST_CHAIN_INVALID_2), false);
    });

    test('isValidAccount', () {
      expect(
        NamespaceUtils.isValidAccount(
          TEST_ETHEREUM_ACCOUNT,
        ),
        true,
      );
      expect(NamespaceUtils.isValidAccount(TEST_ACCOUNT_INVALID_1), false);
      expect(NamespaceUtils.isValidAccount(TEST_ACCOUNT_INVALID_2), false);
      expect(NamespaceUtils.isValidAccount(TEST_ACCOUNT_INVALID_3), false);
    });

    test('isValidUrl', () {
      expect(
        NamespaceUtils.isValidUrl(TEST_RELAY_URL),
        true,
      );
    });

    test('getAccount', () {
      expect('invalid', 'invalid');
      expect(
        NamespaceUtils.getAccount(TEST_ACCOUNTS[0]),
        TEST_ACCOUNTS[0].split(':')[2],
      );
    });

    test('getChainFromAccount', () {
      expect('invalid', 'invalid');
      expect(
        NamespaceUtils.getChainFromAccount(TEST_ACCOUNTS[0]),
        TEST_CHAINS[0],
      );
    });

    test('getChainsFromAccounts', () {
      expect(NamespaceUtils.getChainsFromAccounts([]), []);
      expect(
        NamespaceUtils.getChainsFromAccounts(TEST_ACCOUNTS),
        TEST_CHAINS,
      );
      expect(
        NamespaceUtils.getChainsFromAccounts(
          [
            ...TEST_ACCOUNTS,
            ...TEST_ACCOUNTS,
          ],
        ),
        TEST_CHAINS,
      );
    });

    test('getChainsFromNamespace', () {
      expect(
        NamespaceUtils.getChainsFromNamespace(
          nsOrChainId: EVM_NAMESPACE,
          namespace: TEST_ETH_ARB_NAMESPACE,
        ),
        TEST_CHAINS,
      );
      expect(
        NamespaceUtils.getChainsFromNamespace(
          nsOrChainId: TEST_AVALANCHE_CHAIN,
          namespace: TEST_AVA_NAMESPACE,
        ),
        [TEST_AVALANCHE_CHAIN],
      );
    });

    test('getChainsFromNamespaces', () {
      expect(
        NamespaceUtils.getChainsFromNamespaces(
          namespaces: TEST_NAMESPACES,
        ),
        [...TEST_CHAINS, TEST_AVALANCHE_CHAIN],
      );
    });

    test('getNamespacesMethodsForChainId', () {
      expect(
        NamespaceUtils.getNamespacesMethodsForChainId(
          chainId: TEST_ETHEREUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        TEST_METHODS_1,
      );
      expect(
        NamespaceUtils.getNamespacesMethodsForChainId(
          chainId: TEST_ARBITRUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        TEST_METHODS_1,
      );
      expect(
        NamespaceUtils.getNamespacesMethodsForChainId(
          chainId: TEST_AVALANCHE_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        TEST_METHODS_2,
      );
    });

    test('getNamespacesEventsForChainId', () {
      expect(
        NamespaceUtils.getNamespacesEventsForChainId(
          chainId: TEST_ETHEREUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        [TEST_EVENT_1],
      );
      expect(
        NamespaceUtils.getNamespacesEventsForChainId(
          chainId: TEST_ARBITRUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        [TEST_EVENT_1],
      );
      expect(
        NamespaceUtils.getNamespacesEventsForChainId(
          chainId: TEST_AVALANCHE_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        [TEST_EVENT_2],
      );
    });

    test('getChainsFromRequiredNamespace', () {
      expect(
        NamespaceUtils.getChainsFromRequiredNamespace(
          nsOrChainId: EVM_NAMESPACE,
          requiredNamespace: TEST_ETH_ARB_REQUIRED_NAMESPACE,
        ),
        TEST_CHAINS,
      );
      expect(
        NamespaceUtils.getChainsFromRequiredNamespace(
          nsOrChainId: TEST_AVALANCHE_CHAIN,
          requiredNamespace: TEST_AVA_REQUIRED_NAMESPACE,
        ),
        [TEST_AVALANCHE_CHAIN],
      );
    });

    test('getChainsFromRequiredNamespaces', () {
      expect(
        NamespaceUtils.getChainsFromRequiredNamespaces(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        ),
        [...TEST_CHAINS, TEST_AVALANCHE_CHAIN],
      );
    });
  });

  group('SignApiValidatorUtils', () {
    test('isContainedIn', () {
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['a', 'b'],
        ),
        true,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['b'],
        ),
        true,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: [],
        ),
        true,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['c'],
        ),
        false,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['a', 'b', 'c'],
        ),
        false,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['a', 'c'],
        ),
        false,
      );
    });
  });

  test('isValidChains', () {
    expect(
      SignApiValidatorUtils.isValidChains(
        nsOrChainId: TEST_ETHEREUM_CHAIN,
        context: 'test',
      ),
      true,
    );
    expect(
      SignApiValidatorUtils.isValidChains(
        nsOrChainId: EVM_NAMESPACE,
        chains: TEST_CHAINS,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidChains(
        nsOrChainId: TEST_ETHEREUM_CHAIN,
        chains: TEST_CHAINS,
        context: 'test',
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          "Unsupported chains. test, namespace is a chainId, but chains is not empty",
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidChains(
        nsOrChainId: EVM_NAMESPACE,
        chains: TEST_CHAINS_INVALID,
        context: 'test',
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. test, chain $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId" format',
        ),
      ),
    );
  });

  test('isValidRequiredNamespaces', () {
    expect(
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        context: 'test',
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          "Unsupported chains. test requiredNamespace, namespace is a chainId, but chains is not empty",
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_2,
        context: 'test',
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. test requiredNamespace, chain $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId" format',
        ),
      ),
    );
  });

  test('isValidAccounts', () {
    expect(
      SignApiValidatorUtils.isValidAccounts(
        accounts: TEST_ACCOUNTS,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidAccounts(
        accounts: TEST_ACCOUNTS_INVALID,
        context: 'test',
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. test, account $TEST_ACCOUNT_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespaces', () {
    expect(
      SignApiValidatorUtils.isValidNamespaces(
        namespaces: TEST_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespaces(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        context: 'test',
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. test namespace, account $TEST_ACCOUNT_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespacesChainId', () {
    expect(
      SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_UNINCLUDED_CHAIN,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. The chain $TEST_UNINCLUDED_CHAIN is not supported',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_CHAIN_INVALID_1,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. chain $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId" format',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        chainId: TEST_ETHEREUM_CHAIN,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. isValidNamespacesChainId namespace, account $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespacesRequest', () {
    expect(
      SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_3,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported methods. The method $TEST_METHOD_3 is not supported',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_CHAIN_INVALID_1,
        method: TEST_METHOD_1,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. chain $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId" format',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. isValidNamespacesRequest namespace, account $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespacesEvent', () {
    expect(
      SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        eventName: TEST_EVENT_1,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        eventName: TEST_EVENT_2,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported events. The event $TEST_EVENT_2 is not supported',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_CHAIN_INVALID_1,
        eventName: TEST_EVENT_1,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. chain $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId" format',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        chainId: TEST_ETHEREUM_CHAIN,
        eventName: TEST_EVENT_1,
      ),
      throwsA(
        isA<WalletConnectError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. isValidNamespacesEvent namespace, account $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isConformingNamespaces', () {
    expect(
      SignApiValidatorUtils.isConformingNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        namespaces: TEST_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    expect(
      SignApiValidatorUtils.isConformingNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        namespaces: TEST_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    final List nonconformingNamespaces = [
      TEST_NAMESPACES_NONCONFORMING_KEY_1,
      TEST_NAMESPACES_NONCONFORMING_KEY_2,
      TEST_NAMESPACES_NONCONFORMING_CHAINS,
      TEST_NAMESPACES_NONCONFORMING_METHODS,
      TEST_NAMESPACES_NONCONFORMING_EVENTS,
    ];
    final List errors = [
      "Non conforming namespaces. test namespaces keys don't satisfy requiredNamespaces",
      "Non conforming namespaces. test namespaces keys don't satisfy requiredNamespaces",
      "Non conforming namespaces. test namespaces accounts don't satisfy requiredNamespaces chains for $EVM_NAMESPACE",
      "Non conforming namespaces. test namespaces methods don't satisfy requiredNamespaces methods for $EVM_NAMESPACE",
      "Non conforming namespaces. test namespaces events don't satisfy requiredNamespaces events for $EVM_NAMESPACE",
    ];
    for (int i = 0; i < nonconformingNamespaces.length; i++) {
      expect(
        () => SignApiValidatorUtils.isConformingNamespaces(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          namespaces: nonconformingNamespaces[i],
          context: 'test',
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            errors[i],
          ),
        ),
      );
    }
  });

  test('isSessionCompatible', () {
    expect(
      SignApiValidatorUtils.isSessionCompatible(
        session: testSessionValid,
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
      ),
      true,
    );
    final List nonconformingNamespaces = [
      TEST_NAMESPACES_NONCONFORMING_KEY_1,
      TEST_NAMESPACES_NONCONFORMING_KEY_2,
      TEST_NAMESPACES_NONCONFORMING_CHAINS,
      TEST_NAMESPACES_NONCONFORMING_METHODS,
      TEST_NAMESPACES_NONCONFORMING_EVENTS,
    ];
    for (int i = 0; i < nonconformingNamespaces.length; i++) {
      testSessionValid.namespaces = nonconformingNamespaces[i];
      expect(
        SignApiValidatorUtils.isSessionCompatible(
          session: testSessionValid,
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        ),
        false,
      );
    }
  });
}
