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
