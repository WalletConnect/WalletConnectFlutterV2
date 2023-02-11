import 'package:wallet_connect_flutter_v2/wallet_connect_flutter_v2.dart';

const TEST_ETHEREUM_CHAIN = "eip155:1";

const TEST_SIG_EIP1271 =
    '0xc1505719b2504095116db01baaf276361efd3a73c28cf8cc28dabefa945b8d536011289ac0a3b048600c1e692ff173ca944246cf7ceb319ac2262d27b395c82b1c';
const TEST_ADDRESS_EIP1271 = '0x2faf83c542b68f1b4cdc0e770e8cb9f567b08f71';
const TEST_MESSAGE_EIP1271 =
    '''localhost wants you to sign in with your Ethereum account:
$TEST_ADDRESS_EIP1271
URI: http://localhost:3000/
Version: 1
Chain ID: 1
Nonce: 1665443015700
Issued At: 2022-10-10T23:03:35.700Z
Expiration Time: 2022-10-11T23:03:35.700Z''';

const TEST_SIG_EIP191 =
    '0x560a65deed4aaf332d9dbab82af897245c93139773b483072d5e59afdc5788d76e1dcbefaef36b11a52755bfd152241b4ea03d2cc08638818c5105cba9beb83d1c';
const TEST_PRIVATE_KEY_EIP191 =
    '5c0caa455d5354515baae31e01421db4763f21a25dfbffd32052deeb3076dbbb';
const TEST_ADDRESS_EIP191 = '0x06C6A22feB5f8CcEDA0db0D593e6F26A3611d5fa';
const TEST_MESSAGE_EIP191 = 'Hello World';

const TEST_SIGNATURE_FAIL =
    '0xdead5719b2504095116db01baaf276361efd3a73c28cf8cc28dabefa945b8d536011289ac0a3b048600c1e692ff173ca944246cf7ceb319ac2262d27b395c82b1c';

const TEST_ISSUER_EIP191 = 'did:pkh:$TEST_ETHEREUM_CHAIN:$TEST_ADDRESS_EIP191';

const TEST_CACAO_SIGNATURE = CacaoSignature(
  t: CacaoSignature.EIP191,
  s: TEST_SIG_EIP191,
);
