import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/sign_api_validator_utils.dart';
import 'package:walletconnect_flutter_v2/apis/utils/namespace_utils.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import '../sign_api/utils/sign_client_constants.dart';

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

    test('getNamespaceFromChain', () {
      expect(NamespaceUtils.getNamespaceFromChain('invalid'), 'invalid');
      expect(
        NamespaceUtils.getNamespaceFromChain(TEST_ETHEREUM_CHAIN),
        'eip155',
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

    group('constructNamespaces', () {
      test('constructs namespaces with required namespaces', () {
        Map<String, Namespace> namespaces = NamespaceUtils.constructNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: requiredNamespaces,
        );

        // Expect 2 namespaces
        expect(namespaces.keys.length, 2);
        expect(
          namespaces['namespace1:chain1']!.accounts,
          availableAccounts['namespace1:chain1'],
        );
        expect(
          namespaces['namespace1:chain1']!.events,
          ['event1', 'event2'],
        );
        expect(
          namespaces['namespace1:chain1']!.methods,
          ['method1', 'method2'],
        );
        expect(
          namespaces['namespace2']!.accounts,
          availableAccounts['namespace2'],
        );
        expect(
          namespaces['namespace2']!.events,
          ['event5', 'event6'],
        );
        expect(
          namespaces['namespace2']!.methods,
          ['method6'],
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespaces,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );
      });

      test('constructs namespaces with optional namespaces', () {
        Map<String, Namespace> namespaces = NamespaceUtils.constructNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: requiredNamespaces,
          optionalNamespaces: optionalNamespaces,
        );

        // print(namespaces);
        expect(namespaces.keys.length, 3);
        expect(
          namespaces['namespace1:chain2']!.accounts,
          availableAccounts['namespace1:chain2'],
        );
        expect(
          namespaces['namespace1:chain2']!.events,
          availableEvents['namespace1:chain2'],
        );
        expect(
          namespaces['namespace1:chain2']!.methods,
          ['method3', 'method4'],
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespaces,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );
      });
    });
  });
}
