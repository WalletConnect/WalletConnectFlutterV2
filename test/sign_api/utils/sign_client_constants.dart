import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';

const TEST_RELAY_OPTIONS = {
  "protocol": WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
};

const EVM_NAMESPACE = 'eip155';

const TEST_ARBITRUM_CHAIN = "eip155:42161";
const TEST_AVALANCHE_CHAIN = "eip155:43114";
const TEST_UNINCLUDED_CHAIN = "eip155:2";

const TEST_CHAINS = [
  TEST_ETHEREUM_CHAIN,
  TEST_ARBITRUM_CHAIN,
];
const TEST_CHAIN_INVALID_1 = "swag";
const TEST_CHAIN_INVALID_2 = "s:w:a";
const TEST_CHAINS_INVALID = [
  TEST_CHAIN_INVALID_1,
  TEST_CHAIN_INVALID_2,
];

const TEST_ETHEREUM_ADDRESS = "0x3c582121909DE92Dc89A36898633C1aE4790382b";

const TEST_ETHEREUM_ACCOUNT = "$TEST_ETHEREUM_CHAIN:$TEST_ETHEREUM_ADDRESS";
const TEST_ARBITRUM_ACCOUNT = "$TEST_ARBITRUM_CHAIN:$TEST_ETHEREUM_ADDRESS";
const TEST_AVALANCHE_ACCOUNT = "$TEST_AVALANCHE_CHAIN:$TEST_ETHEREUM_ADDRESS";

const TEST_ACCOUNTS = [
  TEST_ETHEREUM_ACCOUNT,
  TEST_ARBITRUM_ACCOUNT,
];
const TEST_ACCOUNT_INVALID_1 = 'swag';
const TEST_ACCOUNT_INVALID_2 = 's:w';
const TEST_ACCOUNT_INVALID_3 = 's:w:a:g';
const TEST_ACCOUNTS_INVALID = [
  TEST_ACCOUNT_INVALID_1,
  TEST_ACCOUNT_INVALID_2,
  TEST_ACCOUNT_INVALID_3,
];

const TEST_METHOD_1 = 'eth_sendTransaction';
const TEST_METHOD_2 = 'eth_signTransaction';
const TEST_METHOD_3 = 'personal_sign';
const TEST_METHOD_4 = 'eth_signTypedData';
const TEST_METHODS_1 = [
  TEST_METHOD_1,
  TEST_METHOD_2,
];
const TEST_METHODS_2 = [
  TEST_METHOD_3,
  TEST_METHOD_4,
];
const TEST_METHODS_FULL = [
  ...TEST_METHODS_1,
  ...TEST_METHODS_2,
];
const TEST_METHOD_INVALID_1 = 'eth_invalid';

const TEST_EVENT_1 = "chainChanged";
const TEST_EVENT_2 = "accountsChanged";
const TEST_EVENTS_FULL = [
  TEST_EVENT_1,
  TEST_EVENT_2,
];
const TEST_EVENT_INVALID_1 = 'eth_event_invalid';

const TEST_ETH_ARB_REQUIRED_NAMESPACE = RequiredNamespace(
  chains: TEST_CHAINS,
  methods: TEST_METHODS_1,
  events: [TEST_EVENT_1],
);
const TEST_AVA_REQUIRED_NAMESPACE = RequiredNamespace(
  methods: TEST_METHODS_2,
  events: [TEST_EVENT_2],
);
const TEST_REQUIRED_NAMESPACES = {
  EVM_NAMESPACE: TEST_ETH_ARB_REQUIRED_NAMESPACE,
  TEST_AVALANCHE_CHAIN: TEST_AVA_REQUIRED_NAMESPACE,
};

const TEST_ETH_ARB_NAMESPACE = Namespace(
  accounts: TEST_ACCOUNTS,
  methods: TEST_METHODS_1,
  events: [TEST_EVENT_1],
);
const TEST_AVA_NAMESPACE = Namespace(
  accounts: [TEST_AVALANCHE_ACCOUNT],
  methods: TEST_METHODS_2,
  events: [TEST_EVENT_2],
);
const TEST_NAMESPACES = {
  EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE,
  TEST_AVALANCHE_CHAIN: TEST_AVA_NAMESPACE,
};

// Invalid RequiredNamespaces
const TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1 = {
  "eip155:2": TEST_ETH_ARB_REQUIRED_NAMESPACE,
};
const TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_2 = {
  EVM_NAMESPACE: RequiredNamespace(
    chains: ['eip155:1', TEST_CHAIN_INVALID_1],
    methods: [],
    events: [],
  ),
};

// Invalid Namespaces
const TEST_NAMESPACES_INVALID_ACCOUNTS = {
  EVM_NAMESPACE: Namespace(
    accounts: [TEST_ACCOUNT_INVALID_1],
    methods: TEST_METHODS_FULL,
    events: TEST_EVENTS_FULL,
  ),
};

// Invalid Conforming Namespaces
const TEST_NAMESPACES_NONCONFORMING_KEY_VALUE = 'eip1111';
const TEST_NAMESPACES_NONCONFORMING_KEY_1 = {
  TEST_NAMESPACES_NONCONFORMING_KEY_VALUE: Namespace(
    accounts: TEST_ACCOUNTS,
    methods: TEST_METHODS_FULL,
    events: TEST_EVENTS_FULL,
  )
};
const TEST_NAMESPACES_NONCONFORMING_KEY_2 = {
  EVM_NAMESPACE: Namespace(
    accounts: TEST_ACCOUNTS,
    methods: TEST_METHODS_FULL,
    events: TEST_EVENTS_FULL,
  ),
};
const TEST_NAMESPACES_NONCONFORMING_CHAINS = {
  EVM_NAMESPACE: Namespace(
    accounts: [TEST_ETHEREUM_ACCOUNT],
    methods: TEST_METHODS_FULL,
    events: TEST_EVENTS_FULL,
  ),
  TEST_AVALANCHE_CHAIN: TEST_AVA_NAMESPACE,
};
const TEST_NAMESPACES_NONCONFORMING_METHODS = {
  EVM_NAMESPACE: Namespace(
    accounts: TEST_ACCOUNTS,
    methods: [TEST_METHOD_INVALID_1],
    events: TEST_EVENTS_FULL,
  ),
  TEST_AVALANCHE_CHAIN: TEST_AVA_NAMESPACE,
};
const TEST_NAMESPACES_NONCONFORMING_EVENTS = {
  EVM_NAMESPACE: Namespace(
    accounts: TEST_ACCOUNTS,
    methods: TEST_METHODS_FULL,
    events: [TEST_EVENT_INVALID_1],
  ),
  TEST_AVALANCHE_CHAIN: TEST_AVA_NAMESPACE,
};

// Session Data
const TEST_SESSION_INVALID_TOPIC = 'swagmaster';
const TEST_SESSION_VALID_TOPIC = 'abc';
const TEST_SESSION_EXPIRED_TOPIC = 'expired';
final testSessionValid = SessionData(
  topic: TEST_SESSION_VALID_TOPIC,
  pairingTopic: TEST_PAIRING_TOPIC,
  relay: Relay('irn'),
  expiry: 1000000000000,
  acknowledged: true,
  controller: 'test',
  namespaces: TEST_NAMESPACES,
  requiredNamespaces: {
    EVM_NAMESPACE: TEST_ETH_ARB_REQUIRED_NAMESPACE,
  },
  optionalNamespaces: {},
  self: ConnectionMetadata(
    publicKey: '',
    metadata: PairingMetadata(name: '', description: '', url: '', icons: []),
  ),
  peer: ConnectionMetadata(
    publicKey: '',
    metadata: PairingMetadata(name: '', description: '', url: '', icons: []),
  ),
);
final testSessionExpired = SessionData(
  topic: TEST_SESSION_EXPIRED_TOPIC,
  pairingTopic: TEST_PAIRING_TOPIC,
  relay: Relay('irn'),
  expiry: -1,
  acknowledged: true,
  controller: 'test',
  namespaces: TEST_NAMESPACES,
  requiredNamespaces: TEST_REQUIRED_NAMESPACES,
  optionalNamespaces: {},
  self: ConnectionMetadata(
    publicKey: '',
    metadata: PairingMetadata(name: '', description: '', url: '', icons: []),
  ),
  peer: ConnectionMetadata(
    publicKey: '',
    metadata: PairingMetadata(name: '', description: '', url: '', icons: []),
  ),
);

// Test Messages

const TEST_MESSAGE_1 = {"test": "Hello"};
const TEST_MESSAGE_2 = 'Hello';

const TEST_MESSAGE = "My name is John Doe";
const TEST_SIGNATURE =
    "0xc8906b32c9f74d0805226ffff5ecd6897ea55cdf58f54a53a2e5b5d5a21fb67f43ef1d4c2ed790a724a1549b4cc40137403048c4aed9825cfd5ba6c1d15bd0721c";

const TEST_SIGN_METHOD = "personal_sign";
const TEST_SIGN_PARAMS = [
  TEST_MESSAGE,
  TEST_ETHEREUM_ADDRESS,
];
const TEST_SIGN_REQUEST = {
  "method": TEST_SIGN_METHOD,
  "params": TEST_SIGN_PARAMS
};

const TEST_RANDOM_REQUEST = {"method": "random_method", "params": []};
