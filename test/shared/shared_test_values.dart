import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

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

const TEST_RELAY_URL = String.fromEnvironment(
  'RELAY_ENDPOINT',
  defaultValue: 'wss://relay.walletconnect.com',
);
const TEST_PROJECT_ID = String.fromEnvironment(
  'PROJECT_ID',
  defaultValue: '7e984f90b95f0236d3c12d791537f233',
);

const TEST_PAIRING_TOPIC = '';
const TEST_SESSION_TOPIC = '';
const TEST_KEY_PAIRS = {
  'A': const CryptoKeyPair(
    '1fb63fca5c6ac731246f2f069d3bc2454345d5208254aa8ea7bffc6d110c8862',
    'ff7a7d5767c362b0a17ad92299ebdb7831dcbd9a56959c01368c7404543b3342',
  ),
  'B': const CryptoKeyPair(
    '36bf507903537de91f5e573666eaa69b1fa313974f23b2b59645f20fea505854',
    '590c2c627be7af08597091ff80dd41f7fa28acd10ef7191d7e830e116d3a186a',
  ),
};

const TEST_SHARED_KEY =
    "9c87e48e69b33a613907515bcd5b1b4cc10bbaf15167b19804b00f0a9217e607";
const TEST_HASHED_KEY =
    "a492906ccc809a411bb53a84572b57329375378c6ad7566f3e1c688200123e77";
const TEST_SYM_KEY =
    "0653ca620c7b4990392e1c53c4a51c14a2840cd20f0f1524cf435b17b6fe988c";

const TEST_URI =
    "wc:7f6e504bfad60b485450578e05678ed3e8e8c4751d3c6160be17160d63ec90f9@2?symKey=587d5484ce2a2a6ee3ba1962fdd7e8588e06200c46823bd18fbd67def96ad303&relay-protocol=irn";

const TEST_ETHEREUM_CHAIN = 'eip155:1';

final Map<String, Set<String>> availableAccounts = {
  'namespace1:chain1': Set<String>.from([
    'namespace1:chain1:acc1',
    'namespace1:chain1:acc2',
  ]),
  'namespace1:chain2': Set<String>.from([
    'namespace1:chain2:acc3',
    'namespace1:chain2:acc4',
  ]),
  'namespace1': Set<String>.from([
    'namespace1:chain1:acc7',
    'namespace1:chain1:acc8',
  ]),
  'namespace2': Set<String>.from([
    'namespace2:chain1:acc5',
    'namespace2:chain2:acc6',
  ]),
};

final List<String> availableMethods = [
  'namespace1:chain1:method1',
  'namespace1:chain1:method2',
  'namespace1:chain2:method3',
  'namespace1:chain2:method4',
  'namespace2:chain1:method5',
  'namespace2:chain1:method6',
  'namespace2:chain2:method6',
];

final Map<String, Set<String>> availableEvents = {
  'namespace1:chain1': Set<String>.from(['event1', 'event2']),
  'namespace1:chain2': Set<String>.from(['event3', 'event4']),
  'namespace2': Set<String>.from(['event5', 'event6']),
};

final Map<String, RequiredNamespace> requiredNamespaces = {
  'namespace1:chain1': RequiredNamespace(
    methods: ['method1', 'method2'],
    events: ['event1', 'event2'],
  ),
  'namespace2': RequiredNamespace(
    methods: ['method6'],
    events: ['event5', 'event6'],
    chains: ['namespace2:chain1', 'namespace2:chain2'],
  ),
};

final Map<String, RequiredNamespace> optionalNamespaces = {
  'namespace1:chain2': RequiredNamespace(
    methods: ['method3', 'method4'],
    events: ['event3', 'event4'],
  ),
};
