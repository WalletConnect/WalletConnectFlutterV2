# Overview

A pure dart fork of WalletConnect/WalletConnectFlutterV2

Original work for this library is attributed to [Eucalyptus Labs](https://eucalyptuslabs.com/) and Sterling Long for [Koala Wallet](https://koalawallet.io/), a wallet built for the Kadena blockchain.

# To Use

## Pair, Approve, and Sign/Auth

### dApp Flow

```dart
// To create both an Auth and Sign API, you can use the Web3App
// If you just need one of the other, replace Web3App with SignClient or AuthClient
// SignClient wcClient = await SignClient.createInstance(
// AuthClient wcClient = await AuthClient.createInstance(
Web3App wcClient = await Web3App.createInstance(
  relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
  projectId: '123',
  metadata: PairingMetadata(
    name: 'dApp (Requester)',
    description: 'A dapp that can request that transactions be signed',
    url: 'https://walletconnect.com',
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
  ),
);

// For a dApp, you would connect with specific parameters, then display
// the returned URI.
ConnectResponse resp = await wcClient.connect(
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
);
Uri? uri = resp.uri;

// Once you've display the URI, you can wait for the future, and hide the QR code once you've received session data
final SessionData session = await resp.session.future;

// Now that you have a session, you can request signatures
final dynamic signResponse = await wcClient.request(
  topic: session.topic,
  chainId: 'eip155:1',
  request: SessionRequestParams(
    method: 'eth_signTransaction',
    params: 'json serializable parameters',
  ),
);
// Unpack, or use the signResponse.
// Structure is dependant upon the JSON RPC call you made.


// You can also request authentication
final AuthRequestResponse authReq = await wcClient.requestAuth(
  params: AuthRequestParams(
    aud: 'http://localhost:3000/login',
    domain: 'localhost:3000',
    chainId: 'eip155:1',
    statement: 'Sign in with your wallet!',
  ),
  pairingTopic: resp.pairingTopic,
);

// Await the auth response using the provided completer
final AuthResponse authResponse = await authResponse.completer.future;
if (authResponse.result != null) {
  // Having a result means you have the signature and it is verified.

  // Retrieve the wallet address from a successful response
  final walletAddress = AddressUtils.getDidAddress(authResponse.result!.p.iss);
}
else {
  // Otherwise, you might have gotten a WalletConnectError if there was un issue verifying the signature.
  final WalletConnectError? error = authResponse.error;
  // Of a JsonRpcError if something went wrong when signing with the wallet.
  final JsonRpcError? error = authResponse.jsonRpcError;
}


// You can also respond to events from the wallet, like session events
wcClient.onSessionEvent.subscribe((SessionEvent? session) {
  // Do something with the event
});
wcClient.registerEventHandler(
  chainId: 'kadena',
  event: 'kadena_transaction_updated',
);
```

### Wallet Flow

```dart
Web3Wallet wcClient = await Web3Wallet.createInstance(
  relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
  projectId: '123',
  metadata: PairingMetadata(
    name: 'Wallet (Responder)',
    description: 'A wallet that can be requested to sign transactions',
    url: 'https://walletconnect.com',
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
  ),
);

// For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
late int id;
wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
  // Handle UI updates using the args.params
  // Keep track of the args.id for the approval response
  id = args!.id;
});

// Also setup the methods and chains that your wallet supports
final kadenaSignV1RequestHandler = (String topic, dynamic parameters) async {
  // Handling Steps
  // 1. Parse the request, if there are any errors thrown while trying to parse
  // the client will automatically respond to the requester with a
  // JsonRpcError.invalidParams error
  final parsedResponse = parameters;

  // 1. If you want to fail silently, you can throw a WalletConnectErrorSilent
  if (failSilently) {
    throw WalletConnectErrorSilent();
  }

  // 2. Show a modal to the user with the signature info: Allow approval/rejection
  bool userApproved = await showDialog( // This is an example, you will have to make your own changes to make it work.
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Transaction'),
        content: SizedBox(
          width: 300,
          height: 350,
          child: Text(parsedResponse.toString()),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Accept'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Reject'),
          ),
        ],
      );
    },
  );

  // 3. Respond to the dApp based on user response
  if (userApproved) {
    // Returned value must by a primitive, or a JSON serializable object: Map, List, etc.
    return 'Signed!';
  }
  else {
    // Throw an error if the user rejects the request
    throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
  }
}
wcClient.registerRequestHandler(
  chainId: 'kadena:mainnet01',
  method: 'kadena_sign_v1',
  handler: kadenaSignV1RequestHandler,
);

// Setup the auth handling
clientB.onAuthRequest.subscribe((AuthRequest? args) async {

  // This is where you would
  // 1. Store the information to be signed
  // 2. Display to the user that an auth request has been received

  // You can create the message to be signed in this manner
  String message = clientB.formatAuthMessage(
    iss: TEST_ISSUER_EIP191,
    cacaoPayload: CacaoRequestPayload.fromPayloadParams(
      args!.payloadParams,
    ),
  );
});

// Then, scan the QR code and parse the URI, and pair with the dApp
// On the first pairing, you will immediately receive onSessionProposal and onAuthRequest events.
Uri uri = Uri.parse(scannedUriString);
final PairingInfo pairing = await wcClient.pair(uri: uri);

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
await wcClient.approveSession(
  id: id,
  namespaces: walletNamespaces // This will have the accounts requested in params
);
// Or to reject...
// Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
await wcClient.rejectSession(
  id: id,
  reason: Errors.getSdkError(Errors.USER_REJECTED),
);

// For auth, you can do the same thing: Present the UI to them, and have them approve the signature.
// Then respond with that signature. In this example I use EthSigUtil, but you can use any library that can perform
// a personal eth sign.
String sig = EthSigUtil.signPersonalMessage(
  message: Uint8List.fromList(message.codeUnits),
  privateKey: 'PRIVATE_KEY',
);
await wcClient.respondAuthRequest(
  id: args.id,
  iss: 'did:pkh:eip155:1:ETH_ADDRESS',
  signature: CacaoSignature(t: CacaoSignature.EIP191, s: sig),
);
// Or rejected
// Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
await wcClient.respondAuthRequest(
  id: args.id,
  iss: 'did:pkh:eip155:1:0x06C6A22feB5f8CcEDA0db0D593e6F26A3611d5fa',
  error: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
);

// You can also emit events for the dApp
await wcClient.emitSessionEvent(
  topic: sessionTopic,
  chainId: 'eip155:1',
  event: SessionEventParams(
    name: 'chainChanged',
    data: 'a message!',
  ),
);

// Finally, you can disconnect
await wcClient.disconnectSession(
  topic: pairing.topic,
  reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
);
```

### Reconnecting the WebSocket

```dart
// If your WebSocket dies, you can reconnect it the with the following method
wcClient.core.relayClient.connect();
```

### Responding to Data Changes (Event Handling)

The dart library has all of the events listed in the [specification](https://docs.walletconnect.com/2.0/specs/clients/sign/session-events).

However, instead of using strings to identify the events, each event has it's own dedicated object like so:

```dart
wcClient.onSessionEvent.subscribe((SessionEvent? session) {
  // Do something with the event
});
```

# Platform Permissions

## MacOS

This library requires that you add the following to your `DebugProfile.entitlements` and `Release.entitlements` files so that it can connect to the WebSocket server.

```xml
<key>com.apple.security.network.client</key>
<true/>
```

# To Test

Run tests using

```bash
export PROJECT_ID=xxx
dart test
```

Expected flutter version is: >`3.0.0`

To output logs while testing, you can set the `core.logger.level = Level.info` to see only warnings and errors, or `Level.info` to see all logs.

# Commands Run in CI

- `flutter analyze`
- `dart format --output=none --set-exit-if-changed .`

# Useful Commands

- `flutter pub run build_runner build --delete-conflicting-outputs` - Regenerates JSON Generators
- `flutter doctor -v` - get paths of everything installed.
- `flutter pub get`
- `flutter upgrade`
- `flutter clean`
- `flutter pub cache clean`
- `flutter pub deps`
- `flutter pub run dependency_validator` - show unused dependencies and more
- `dart format lib/* -l 120`
- `flutter analyze`
