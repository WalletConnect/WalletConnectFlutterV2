## 2.1.8

- Minor changes.

## 2.1.5

- Added a core heartbeat to check and expire on pairing and sessions.

## 2.1.4

- Core defaults to `Logger.level = Level.nothing` to prevent logs from being printed by default
- Resolved errors with pairings and sessions trying to subscribe even when the relay wasn't connected
- Additional bugs resolved

## 2.1.3

- Relay Client no longer throws errors on init

## 2.1.2

- No internet connection/invalid URL errors will no longer throw, but the relay's `onRelayClientError` will emit them.
- Oher relay client bug fixes

## 2.1.1

- Fixed issue with relayUrl not being used correctly
- Updated false positive tests for relayUrl and added additional ones to ensure relayUrl is used correctly

## 2.1.0

- Added IWebSocketHandler input to core for testing purposes
- No internet connection/invalid URL errors now throw a WalletConnectError
- .org fallback is used if the relay URL fails

## 2.0.16

- Updated error logs to be more descriptive

## 2.0.15

- Added 1002 and 1005 to relay auto-reconnect

## 2.0.14

- Fixed regression of optionalNamespaces not being nullable

## 2.0.13

- Made message in json response nullable to resolve issues with rejection messages
- Updated readme, added events to RequiredNamespace
- Swapped to `freezed` for all models
- Resolved issue with non-null resources for auth throwing errors

## 2.0.12

- Fixed regression with default relay URL, added tests to ensure it doesn't happen again

## 2.0.11

- Updated relay client's error messages to be accurate and descriptive.

## 2.0.10

- Added logger level where missing
- Updated the `NamespaceUtils` and `SignApiValidatorUtils` to follow [CAIP-217](https://chainagnostic.org/CAIPs/caip-217)

## 2.0.9

- Fixed issue with hanging websocket connection (Missing session)
- Added logs to certain packages to help with debugging
- Updated multiple tests to be more deterministic

## 2.0.8

- Added echo client
- Multiple bug fixes

## 2.0.7

- Bumped multiple versions
- Fixed issue with tests not being deterministic
- dApp example updated based on version bumps

## 2.0.6

- Reverted auth to match eip spec

## 2.0.5

- Added analysis options and enforced them

## 2.0.4

- Fixed issues with relay update
- Resolved RPC ID starting at 1 and incrementing
- Resolved race condition with null check on websocket

## 2.0.3

- Fixed issue with auth formatMessage where it would leave 2 new lines if there was no statement

## 2.0.2

- Added a colon (:) to auth that makes it actually authenticate the message properly
- Fixed issue with mismatched types used in jsonRPC.sendRequest

## 2.0.1

- Fixed an issue where the autonamespace's required namespaces would be overwritten by optional namespaces if they had the same chain

## 2.0.0

- Removed periodic ping from websocket, it was throwing an error on the server side. Periodic check to reconnect is still present.
- Updated the parse URI to handle V1 URIs as well as V2 URIs

## 1.2.3

- Event and request events will only be emitted if they are registered
- Added `WalletConnectErrorSilent` that can be thrown in a requestHandler to fail silently and return nothing to the requester
- Multiple bug fixes

## 1.2.2

- Reverted preflight check for HTTP Errors.

## 1.2.1

- Added `onCreate`, `onUpdate`, `onDelete`, `onSync` events to the Pairings, Sessions, and StoredCacao objects for easier state updates
- Relay now reconnects and resubscribes to active topics when connection WebSocket is lost
- Added heartbeat to websocket to keep connection alive
- Added preflight check for HTTP Errors before connecting to WebSocket

## 1.2.0

- AuthClient and SignClient changed to match the WalletConnect Documentation Specifications
- Added `registerAccounts` and `registerEventEmitters` to the SignClient, if there are accounts or events registered, they will be used to automatically create a Namespaces object and validate the session proposal.

## 1.1.4

- Throw a WalletConnectError in a sign request function handler to return a JsonRpcError to the dApp
- Fixed a bug where function handlers for Web3Wallet and SignClient required returning void

## 1.1.3

- Fixed a bug with sendError not causing an error to be thrown on the client side
- Added `onPairingCreate` event. It is emitted when pair and create are called
- Added `pairing.updateExpiry` time validation.

## 1.1.2

- Fixed an issue with requests crashing if an error was thrown
- Updated README to use function handlers for the request example

## 1.1.1

- Sessions are deleted when their pairing is deleted
- Get Sessions for a Pairing using `getSessionsForPairing`
- Get completed Auth Requests for a Pairing using `getCompletedAuthRequestsForPairing`
- Optional value for WcSessionProposeRequest `optionalNamespaces`
- Other bug fixes

## 1.1.0

- Added reconnect and event information to readme
- Pairing and Sessions now resubscribe to events when the relay is created

## 1.0.8

- Fixed an issue where pairings weren't getting persisted to storage

## 1.0.7

- Removed " from methods in URL
- Simplified using `createInstance` static functions
- ConnectResponse completer now explicitly completes with a SessionData object

## 1.0.6

- RequiredNamespaces and ProposalData now exlude null fields in JSON

## 1.0.5

- Added generated files back in

## 1.0.4

- Fixed bug when scanning URI with no `method` query parameter
- Fixed relay not emiting connect or disconnect events when it should have
- Added tests for both of the above

## 1.0.3

- Added more WalletConnect error codes to Errors static class
- Remove WalletConnectErrorReason, just use `WalletConnectError.copyWith` if you need to provide data to an error.

## 1.0.2

- Removed HEX dependency
- Upgraded websocket dependency to 2.3.0, so that the `ready` property exists

## 1.0.1

- Fixed issues with Session Settle Request not allowing null required and optional namespaces
- Fixed issues with `connect` and `requestAuth` not allowing you to provide required methods for the URI
- More tests

## 1.0.0

- Initial release
