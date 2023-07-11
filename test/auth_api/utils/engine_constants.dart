import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import 'signature_constants.dart';

const TEST_AUD = 'http://localhost:3000/login';
const TEST_AUD_INVALID = '<>:http://localhost:3000/login';
const TEST_DOMAIN = 'localhost:3000';
// Invliad because it isn't contained in the audience (aud)
const TEST_DOMAIN_INVALID = 'example.com:3000';

const TEST_PUBLIC_KEY_A = '0x123';
const TEST_PUBLIC_KEY_B = '0xxyz';

const TEST_METADATA_REQUESTER = PairingMetadata(
  name: 'client (requester)',
  description: 'Test Client as Requester',
  url: 'www.walletconnect.com',
  icons: [],
);
const TEST_METADATA_RESPONDER = PairingMetadata(
  name: 'peer (responder)',
  description: 'Test Client as Peer/Responder',
  url: 'www.walletconnect.com',
  icons: [],
);
const TEST_CONNECTION_METADATA_REQUESTER = ConnectionMetadata(
  publicKey: TEST_PUBLIC_KEY_A,
  metadata: TEST_METADATA_REQUESTER,
);

final defaultRequestParams = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: 'localhost:3000',
  aud: TEST_AUD,
  resources: ['test'],
);

final testAuthRequestParamsValid = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: TEST_DOMAIN,
  aud: TEST_AUD,
);
final testAuthRequestParamsInvalidAud = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: TEST_DOMAIN,
  aud: TEST_AUD_INVALID,
);
final testAuthRequestParamsInvalidDomain = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: TEST_DOMAIN_INVALID,
  aud: TEST_AUD,
);
final testAuthRequestParamsInvalidNonce = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: TEST_DOMAIN,
  nonce: '',
  aud: TEST_AUD,
);
final testAuthRequestParamsInvalidType = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: TEST_DOMAIN,
  aud: TEST_AUD,
  type: 'abc',
);
final testAuthRequestParamsInvalidExpiry = AuthRequestParams(
  chainId: TEST_ETHEREUM_CHAIN,
  domain: TEST_DOMAIN,
  aud: TEST_AUD,
  expiry: 0,
);

const testCacaoRequestPayload = CacaoRequestPayload(
  domain: TEST_DOMAIN,
  aud: TEST_AUD,
  version: '1',
  nonce: '100',
  iat: '2022-10-10T23:03:35.700Z',
);
final CacaoPayload testCacaoPayload = CacaoPayload.fromRequestPayload(
  issuer: TEST_ISSUER_EIP191,
  payload: testCacaoRequestPayload,
);
const TEST_FORMATTED_MESSAGE =
    '''localhost:3000 wants you to sign in with your Ethereum account:
0x06C6A22feB5f8CcEDA0db0D593e6F26A3611d5fa


URI: http://localhost:3000/login
Version: 1
Chain ID: 1
Nonce: 100
Issued At: 2022-10-10T23:03:35.700Z''';

const TEST_PENDING_REQUEST_ID = 1;
const TEST_PENDING_REQUEST_ID_INVALID = -1;
final testPendingRequests = {
  TEST_PENDING_REQUEST_ID: const PendingAuthRequest(
    id: TEST_PENDING_REQUEST_ID,
    pairingTopic: TEST_PAIRING_TOPIC,
    metadata: TEST_CONNECTION_METADATA_REQUESTER,
    cacaoPayload: testCacaoRequestPayload,
  )
};
