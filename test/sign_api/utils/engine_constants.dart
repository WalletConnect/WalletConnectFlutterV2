// Engine Data

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import 'sign_client_constants.dart';

const TEST_TOPIC_INVALID = 'abc';
const TEST_APPROVE_ID_INVALID = -1;

const TEST_PUBLIC_KEY_A = '0x123';
const TEST_PUBLIC_KEY_B = '0xxyz';

const TEST_CONNECTION_METADATA_A = ConnectionMetadata(
  publicKey: TEST_PUBLIC_KEY_A,
  metadata: PairingMetadata(
    name: 'Test Name',
    description: 'Test Description',
    url: 'https://test.com',
    icons: ['https://test.com/icon.png'],
  ),
);

const TEST_PROPOSAL_VALID_ID = 1;
const TEST_PROPOSAL_EXPIRED_ID = 50;
const TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID = 100;
const TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID = 1000;
const TEST_PROPOSAL_VALID = ProposalData(
  id: TEST_PROPOSAL_VALID_ID,
  expiry: 1000000000000,
  relays: [],
  proposer: TEST_CONNECTION_METADATA_A,
  requiredNamespaces: TEST_REQUIRED_NAMESPACES,
  optionalNamespaces: {},
);
const TEST_PROPOSAL_EXPIRED = ProposalData(
  id: TEST_PROPOSAL_EXPIRED_ID,
  expiry: -1,
  relays: [],
  proposer: TEST_CONNECTION_METADATA_A,
  requiredNamespaces: TEST_REQUIRED_NAMESPACES,
  optionalNamespaces: {},
);
const TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES = ProposalData(
  id: TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID,
  expiry: 1000000000000,
  relays: [],
  proposer: TEST_CONNECTION_METADATA_A,
  requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
  optionalNamespaces: {},
);
const TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES = ProposalData(
  id: TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID,
  expiry: 1000000000000,
  relays: [],
  proposer: TEST_CONNECTION_METADATA_A,
  requiredNamespaces: {},
  optionalNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
);
