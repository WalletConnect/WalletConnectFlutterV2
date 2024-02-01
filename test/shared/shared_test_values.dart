import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

const TEST_RELAY_URL = String.fromEnvironment(
  'RELAY_ENDPOINT',
  defaultValue: 'wss://relay.walletconnect.com',
);
const TEST_PROJECT_ID = String.fromEnvironment(
  'PROJECT_ID',
  defaultValue: 'cad4956f31a5e40a00b62865b030c6f8',
);

const PROPOSER = PairingMetadata(
  name: 'App A (Proposer, dapp)',
  description: 'Description of Proposer App run by client A',
  url: 'https://walletconnect.com',
  icons: ['https://avatars.githubusercontent.com/u/37784886'],
);
const RESPONDER = PairingMetadata(
  name: 'App B (Responder, Wallet)',
  description: 'Description of Proposer App run by client B',
  url: 'https://walletconnect.com',
  icons: ['https://avatars.githubusercontent.com/u/37784886'],
);

const TEST_PAIRING_TOPIC = '';
const TEST_SESSION_TOPIC = '';
const TEST_KEY_PAIRS = {
  'A': CryptoKeyPair(
    '1fb63fca5c6ac731246f2f069d3bc2454345d5208254aa8ea7bffc6d110c8862',
    'ff7a7d5767c362b0a17ad92299ebdb7831dcbd9a56959c01368c7404543b3342',
  ),
  'B': CryptoKeyPair(
    '36bf507903537de91f5e573666eaa69b1fa313974f23b2b59645f20fea505854',
    '590c2c627be7af08597091ff80dd41f7fa28acd10ef7191d7e830e116d3a186a',
  ),
};

const TEST_SHARED_KEY =
    '9c87e48e69b33a613907515bcd5b1b4cc10bbaf15167b19804b00f0a9217e607';
const TEST_HASHED_KEY =
    'a492906ccc809a411bb53a84572b57329375378c6ad7566f3e1c688200123e77';
const TEST_SYM_KEY =
    '0653ca620c7b4990392e1c53c4a51c14a2840cd20f0f1524cf435b17b6fe988c';

const TEST_URI =
    'wc:7f6e504bfad60b485450578e05678ed3e8e8c4751d3c6160be17160d63ec90f9@2?symKey=587d5484ce2a2a6ee3ba1962fdd7e8588e06200c46823bd18fbd67def96ad303&relay-protocol=irn';
const TEST_URI_V1 =
    'wc:7f6e504bfad60b485450578e05678ed3e8e8c4751d3c6160be17160d63ec90f9@1?key=abc&bridge=xyz';

const TEST_ETHEREUM_CHAIN = 'eip155:1';

final Set<String> availableAccounts = {
  'namespace1:chain1:address1',
  'namespace1:chain1:address2',
  'namespace2:chain1:address3',
  'namespace2:chain1:address4',
  'namespace2:chain2:address5',
  'namespace4:chain1:address6',
};

final Set<String> availableMethods = {
  'namespace1:chain1:method1',
  'namespace1:chain1:method2',
  'namespace2:chain1:method3',
  'namespace2:chain1:method4',
  'namespace2:chain2:method3',
  'namespace4:chain1:method5',
};

final Set<String> availableEvents = {
  'namespace1:chain1:event1',
  'namespace1:chain1:event2',
  'namespace2:chain1:event3',
  'namespace2:chain1:event4',
  'namespace2:chain2:event3',
  'namespace4:chain1:event5',
};

final Map<String, RequiredNamespace> requiredNamespacesInAvailable = {
  'namespace1:chain1': const RequiredNamespace(
    methods: ['method1'],
    events: ['event1'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1', 'namespace2:chain2'],
    methods: ['method3'],
    events: ['event3'],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesInAvailable2 = {
  'namespace1': const RequiredNamespace(
    methods: ['method1'],
    events: ['event1'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1', 'namespace2:chain2'],
    methods: ['method3'],
    events: ['event3'],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesMatchingAvailable1 = {
  'namespace1:chain1': const RequiredNamespace(
    methods: ['method1', 'method2'],
    events: ['event1', 'event2'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1'],
    methods: ['method3', 'method4'],
    events: ['event3', 'event4'],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesNonconformingAccounts1 =
    {
  'namespace3': const RequiredNamespace(
    chains: ['namespace3:chain1'],
    methods: [],
    events: [],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesNonconformingMethods1 = {
  'namespace1:chain1': const RequiredNamespace(
    methods: ['method1', 'method2', 'method3'],
    events: ['event1', 'event2'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1', 'namespace2:chain2'],
    methods: ['method3'],
    events: ['event3'],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesNonconformingMethods2 = {
  'namespace1:chain1': const RequiredNamespace(
    methods: ['method1', 'method2', 'method3'],
    events: ['event1', 'event2'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1', 'namespace2:chain2'],
    methods: ['method3', 'method4'],
    events: ['event3'],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesNonconformingEvents1 = {
  'namespace1:chain1': const RequiredNamespace(
    methods: ['method1', 'method2'],
    events: ['event1', 'event2', 'event3'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1', 'namespace2:chain2'],
    methods: ['method3'],
    events: ['event3'],
  ),
};

final Map<String, RequiredNamespace> requiredNamespacesNonconformingEvents2 = {
  'namespace1:chain1': const RequiredNamespace(
    methods: ['method1', 'method2'],
    events: ['event1', 'event2', 'event3'],
  ),
  'namespace2': const RequiredNamespace(
    chains: ['namespace2:chain1', 'namespace2:chain2'],
    methods: ['method3'],
    events: ['event3', 'event4'],
  ),
};

Map<String, RequiredNamespace> optionalNamespaces = {
  'namespace4:chain1': const RequiredNamespace(
    methods: ['method5'],
    events: ['event5', 'event2'],
  ),
};

const sepolia = 'eip155:11155111';

final Set<String> availableAccounts3 = {
  '$sepolia:0x99999999999999999999999999',
};

final Set<String> availableMethods3 = {
  '$sepolia:eth_sendTransaction',
  '$sepolia:personal_sign',
  '$sepolia:eth_signTypedData',
  '$sepolia:eth_signTypedData_v4',
  '$sepolia:eth_sign',
};

final Set<String> availableEvents3 = {
  '$sepolia:chainChanged',
  '$sepolia:accountsChanged',
};

final Map<String, RequiredNamespace> requiredNamespacesInAvailable3 = {
  'eip155': const RequiredNamespace(
    chains: [sepolia],
    methods: ['eth_sendTransaction', 'personal_sign'],
    events: ['chainChanged', 'accountsChanged'],
  ),
};

final Map<String, RequiredNamespace> optionalNamespacesInAvailable3 = {
  'eip155': const RequiredNamespace(chains: [
    'eip155:1',
    'eip155:5',
    sepolia,
    'eip155:137',
    'eip155:80001',
    'eip155:42220',
    'eip155:44787',
    'eip155:56',
    'eip155:43114',
    'eip155:42161',
    'eip155:421613',
    'eip155:10',
    'eip155:420',
    'eip155:8453'
  ], methods: [
    'eth_sendTransaction',
    'personal_sign',
    'eth_signTypedData',
    'eth_signTypedData_v4',
    'eth_sign'
  ], events: [
    'chainChanged',
    'accountsChanged',
    'message',
    'disconnect',
    'connect'
  ]),
};
