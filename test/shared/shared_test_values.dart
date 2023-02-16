import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';

const TEST_RELAY_URL = 'wss://relay.walletconnect.com';
const TEST_PROJECT_ID = '7e984f90b95f0236d3c12d791537f233';

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
