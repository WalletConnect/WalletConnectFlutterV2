# Overview

WalletConnect Dart v2 package for WalletKit and AppKit. https://walletconnect.com/.

Check out official docs: https://docs.walletconnect.com/

# To Use

## Pair, Approve, and Sign/Auth

### dApp Flow
```dart
// To create both an Auth and Sign API, you can use the Web3App
// If you just need one of the other, replace Web3App with SignClient or AuthClient
// SignClient wcClient = await SignClient.createInstance(
// AuthClient wcClient = await AuthClient.createInstance(
// BE MINDFUL THAT AuthClient is currently deprecated and will be removed soon.
// Authentication methods, including One-Click Auth, are now withing SignClient
Web3App wcClient = await Web3App.createInstance(
  projectId: '123',
  relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
  metadata: PairingMetadata(
    name: 'Your dApp Name (Requester)',
    description: 'A dapp that can request that transactions be signed',
    url: 'https://walletconnect.com',
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
    redirect: Redirect( // Specially important object if you the Wallet to navigate back to your dapp
      native: 'mydapp://',
      universal: 'https://mydapp.com/app',
    ),
  ),
);

// For a dApp, you would connect with specific parameters, then display
// the returned URI.
ConnectResponse resp = await wcClient.connect(
  optionalNamespaces: {
    'eip155': RequiredNamespace(
       // Any Ethereum chain you want to connect with
      chains: ['eip155:1', 'eip155:5'],
       // Requestable Methods, see MethodsConstants class for reference
      methods: ['personal_sign', 'eth_sendTransaction'],
       // Optional requestable events, see EventsConstants for reference
      events: ['accountsChanged'],
    ),
  },
);
// display connection uri withih a QR code or use it to launch a wallet
Uri? uri = resp.uri;
// Example:
// final encodedUri = Uri.encodeComponent(uri.toString());
// launchUrlString('metamask://wc?uri=$encodedUri', mode: LaunchMode.externalApplication);

// Once you've displayed the URI, you can wait for the future, and hide the QR code once you've received session data
final SessionData session = await resp.session.future;

// Now that you have a session, you can request signatures
final dynamic signResponse = await wcClient.request(
  topic: session.topic,
  chainId: 'eip155:1',
  request: SessionRequestParams(
    method: 'eth_signTransaction',
    params: '{json serializable parameters}',
  ),
);
// Unpack, or use the signResponse.
// Structure is dependant upon the JSON RPC call you made.


// [DEPRECATED]
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
final AuthResponse authResponse = await authReq.completer.future;
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

// Instead of connect() and then requestAuth() you can leverage One-Click Auth
// Which is connection (session proposal) and authentication (SIWE) in just 1 step
final SessionAuthRequestResponse authReq = await wcClient.authenticate(
  params: SessionAuthRequestParams(
    chains: ['eip155:1', 'eip155:5'],
    domain: 'yourdomain.com',
    uri: 'https://yourdomain.com/login',
    nonce: AuthUtils.generateNonce(),
    statement: 'Welcome to my example dApp.',
    methods: ['personal_sign', 'eth_sendTransaction'],
  ),
);
// display authentication uri withih a QR code or use it to launch a wallet
Uri? uri = authReq.uri;
// Example:
// final encodedUri = Uri.encodeComponent(uri.toString());
// launchUrlString('metamask://wc?uri=$encodedUri', mode: LaunchMode.externalApplication);
// IMPORTANT: Not every wallet supports One-Click Auth yet but don't worry, if wallet does not support it, 
// it will fallback to regular session proposal automatically

// Once you've displayed the URI, you can wait for the future, and hide the QR code once you've received session data
final SessionAuthResponse authResponse = await authReq.completer.future;
if (authResponse.session != null) {
  // Having a result means you have succesfully authenticated and created a session
}
else {
  // Otherwise, you might have gotten a WalletConnectError if there was un issue verifying the signature.
  final WalletConnectError? error = authResponse.error;
  // Of a JsonRpcError if something went wrong when signing with the wallet.
  final JsonRpcError? error = authResponse.jsonRpcError;
}



// You can also respond to events from the wallet, like session events
wcClient.registerEventHandler(
  chainId: 'eip155:1',
  event: 'accountsChanged',
);
wcClient.onSessionEvent.subscribe((SessionEvent? session) {
  // Do something with the event
});
```

### Wallet Flow
```dart
Web3Wallet wcClient = await Web3Wallet.createInstance(
  projectId: '123',
  relayUrl: 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
  metadata: PairingMetadata(
    name: 'Your Wallet Name (Responder)',
    description: 'A wallet that can be requested to sign transactions',
    url: 'https://walletconnect.com',
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
    redirect: Redirect( // Specially important object if you want dApps to be able to open you wallet
      native: 'mywallet://',
      universal: 'https://mywallet.com/app',
    ),
  ),
);

// For a wallet, setup the proposal handler that will display the proposal to the user after the URI has been scanned.
late int id;
wcClient.onSessionProposal.subscribe((SessionProposal? args) async {
  // Handle UI updates using the args.params
  // Keep track of the args.id for the approval response
  if (args != null) {
    id = args!.id;
    // To check VerifyAPI validation in regards of the dApp is trying to connnect you can check verifyContext
    // More info about VerifyAPI https://docs.walletconnect.com/web3wallet/verify
    final isScamApp = args.verifyContext?.validation.scam;
    final isInvalidApp = args.verifyContext?.validation.invalid;
    final isValidApp = args.verifyContext?.validation.valid;
    final unknown = args.verifyContext?.validation.unknown;
    //
    // Present the UI to the user, and allow them to reject or approve the proposal
    await wcClient.approveSession(
      id: args.id,
      namespaces: args.params.generatedNamespaces!,
      sessionProperties: args.params.sessionProperties,
    );
    // Or to reject...
    // Error codes and reasons can be found here: https://docs.walletconnect.com/2.0/specs/clients/sign/error-codes
    await wcClient.rejectSession(
      id: id,
      reason: Errors.getSdkError(Errors.USER_REJECTED),
    );
  }
});

// If you are planning to support One-Click Auth then you would have to subscribe to onSessionAuthRequest events
wcClient.onSessionAuthRequest.subscribe((SessionAuthRequest? args) async {
  // Handle UI updates using the args.params
  // Keep track of the args.id for the approval response
  if (args != null) {
    id = args!.id;
    // To check VerifyAPI validation in regards of the dApp is trying to connnect you can check verifyContext
    // More info about VerifyAPI https://docs.walletconnect.com/web3wallet/verify
    final isScamApp = args.verifyContext?.validation.scam;
    final isInvalidApp = args.verifyContext?.validation.invalid;
    final isValidApp = args.verifyContext?.validation.valid;
    final unknown = args.verifyContext?.validation.unknown;
    //
    // Process Authentication request
    final SessionAuthPayload requestPayload = args.authPayload;
    final responsePayload = AuthSignature.populateAuthPayload(
      authPayload: requestPayload,
      chains: ['eip155:1', 'eip155:5'], // Your supported EVM chains
      methods: ['personal_sign', 'etg_sendTransaction'], // Your supported methods
    );
    // For every chain you support you decide to sign a the message
    final message = _web3Wallet!.formatAuthMessage(
      iss: 'did:pkh:eip155:1:0xADDRESS.....',
      cacaoPayload: CacaoRequestPayload.fromSessionAuthPayload(
        responsePayload,
      ),
    );
    // final hexSignature = * signMessage(message) *
    // And creates a Cacao object with it
    final cacao = AuthSignature.buildAuthObject(
      requestPayload: CacaoRequestPayload.fromSessionAuthPayload(
        responsePayload,
      ),
      signature: CacaoSignature(
        t: CacaoSignature.EIP191,
        s: hexSignature,
      ),
      iss: 'did:pkh:eip155:1:0xADDRESS.....',
    );
    //
    // To respond with the signed messages and create a session for the dapp you use approveSessionAuthenticate
    await _web3Wallet!.approveSessionAuthenticate(
      id: args.id,
      auths: [cacao], // You would have here as many cacaos as messages your wallet signed
    );
    // To reject to session authenticate request you use rejectSessionAuthenticate
    await _web3Wallet!.rejectSessionAuthenticate(
      id: args.id,
      reason: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
    );
  }
});

// Also setup the methods and chains that your wallet supports
final signRequestHandler = (String topic, dynamic parameters) async {
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
    // Returned value must be a primitive, or a JSON serializable object: Map, List, etc.
    return 'Signed!';
  }
  else {
    // Throw an error if the user rejects the request
    throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
  }
}

wcClient.registerRequestHandler(
  chainId: 'eip155:1',
  method: 'eth_sendTransaction',
  handler: signRequestHandler,
);

// If you want to the library to handle Namespace validation automatically, 
// you can register your events and accounts like so:
wcClient.registerEventEmitter(
  chainId: 'eip155:1',
  event: 'chainChanged',
);
wcClient.registerAccount(
  chainId: 'eip155:1',
  account: '0xabc',
);

// If your wallet receives a session proposal that it can't make the proper Namespaces for,
// it will broadcast an onSessionProposalError
wcClient.onSessionProposalError.subscribe((SessionProposalError? args) {
  // Handle the error
});

/* [DEPRECATED] */
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
  iss: 'did:pkh:eip155:1:ETH_ADDRESS',
  error: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
);
//

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

Run tests using `flutter test --dart-define=PROJECT_ID=xxx`.
Expected flutter version is: >`3.0.0`

To output logs while testing, you can set the `core.logger.level = Level.info` to see only warnings and errors, or `Level.info` to see all logs.

# Commands Run in CI

* `flutter analyze`
* `dart format --output=none --set-exit-if-changed .`

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
