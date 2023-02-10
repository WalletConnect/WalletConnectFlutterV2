# Overview

Wallet Connect v2 Flutter library, heavily inspired by the WalletConnect V2 Javacript Monorepo. Original work for this library is attributed to [Eucalyptus Labs](https://eucalyptuslabs.com/) and Sterling Long for [Koala Wallet](https://koalawallet.io/), a wallet built for the Kadena blockchain.

This library currently only contains the Signing API as defined in the Wallet Connect v2 Spec.

# To Use

## Setup

The following code provides an example for setting up the wallet connect client.

```dart
import 'package:wallet_connect_flutter_v2/wallet_connect_flutter_v2.dart';

SignClient wcClient = await SignClient.createInstance(
  Core(
    'wss://relay.walletconnect.com', // The relay websocket URL
    '123', // The project ID
  ),
  self: PairingMetadata(
    'Wallet (Responder)',
    'A wallet that can be requested to sign transactions',
    'https://walletconnect.com',
    ['https://avatars.githubusercontent.com/u/37784886'],
  ),
);
```

## Pair, Approve, and Sign

Now that you have a wallet connect client, you can pair with a dApp,
approve a session and sign from the wallet.

### dApp Flow
```dart
// For a dApp, you would connect with specific parameters, then display
// the returned URI.
ConnectResponse resp = await wcClient.connect(
  ConnectParams(
    requiredNamespaces: {
      'eip155': RequiredNamespace(
        chains: ['eip155:1'], // Ethereum chain
        methods: ['eth_signTransaction'], // Requestable Methods
      ),
      'kadena': RequiredNamespace(
        chains: ['kadena:mainnet01'], // Kadena chain
        methods: ['kadena_quicksign_v1'], // Requestable Methods
      ),
    }
  )
)
Uri? uri = resp.uri;

// Once you've display the URI, you can wait for the future, and hide the QR code once you've received session data
final SessionData session = await resp.session.future;

// Now that you have a session, you can request signatures
final sig = await wcClient.request(
  topic: session.topic,
  chainId: 'eip155:1',
  request: SessionRequestParams(
    method: 'eth_signTransaction',
    params: 'json serializable parameters',
  ),
);
```

### Wallet Flow
```dart
// For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
late int id;
wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
  // Handle UI updates using the args.params
  // Keep track of the args.id for the approval response
  id = args!.id;
})

// Also setup the methods and chains that your wallet supports
final handler = (String topic, dynamic params) async {
  return 'signed!';
};
wcClient.registerRequestHandler(
  namespace: 'kadena',
  method: 'kadena_sign',
  handler: handler,
);

// Then, scan the QR code and parse the URI, and pair with the dApp
// On the first pairing, you will immediately receive a onSessionProposal request.
Uri uri = Uri.parse(scannedUriString);
await wcClient.pair(uri: uri);

// Present the UI to the user, and allow them to reject or approve the proposal
final walletNamespaces = {
  'eip155': Namespace(
    accounts: ['eip155:1:abc'],
    methods: ['eth_signTransaction'],
  ),
  'kadena': Namespace(
    accounts: ['kadena:mainnet01:abc'],
    methods: ['kadena_sign_v1', 'kadena_quicksign_v1'],
    events: ['kadena_transaction_updated'],
  ),
}
await wcClient.approve(
  id: id,
  namespaces: walletNamespaces // This will have the accounts requested in params
);
// Or to reject...
// Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
await wcClient.reject(
  id: id,
  reason: ErrorResponse(
    code: 4001,
    message: "User rejected request",
  ),
);

// Your wallet is setup and ready to go!
```

A wallet exposes different methods for different chains using the `request` function. To register functions that will immediately respond to different requests you must call the 

### Handling Events

```dart
final handler = (String topic, dynamic params) async {
  // Respond to event somehow
};
wcClient.registerEventHandler(
  namespace: 'kadena',
  method: 'kadena_transaction_updated',
  handler: handler,
);
```

# To Build

- Example project and dapp
- Reduce number of crypto libraries used for encryption, shared key, etc.
- Auth API
- Web3Wallet API
- Push API

# To Test

Run tests using `flutter test`.
Expected flutter version is: >`3.3.10`

# Useful Commands

* `flutter pub run build_runner build --delete-conflicting-outputs` - Regenerates JSON Generators
* `flutter doctor -v` - get paths of everything installed.
* `flutter pub get`
* `flutter upgrade`
* `flutter clean`
* `flutter pub cache clean`
* `flutter pub deps`
* `flutter pub run dependency_validator` - show unused dependencies and more
* `dart format lib/* -l 120`
* `flutter analyze`