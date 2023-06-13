import 'package:test/test.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';

void main() {
  group('URIParse', () {
    test('parsed v2 url properly', () {
      URIParseResult parsed = WalletConnectUtils.parseUri(Uri.parse(TEST_URI));
      expect(parsed.protocol, 'wc');
      expect(parsed.version, URIVersion.v2);
      expect(
        parsed.topic,
        '7f6e504bfad60b485450578e05678ed3e8e8c4751d3c6160be17160d63ec90f9',
      );
      expect(
        parsed.v2Data!.symKey,
        '587d5484ce2a2a6ee3ba1962fdd7e8588e06200c46823bd18fbd67def96ad303',
      );
      expect(parsed.v2Data!.relay.protocol, 'irn');
    });

    test('parsed v1 url properly', () {
      URIParseResult parsed = WalletConnectUtils.parseUri(
        Uri.parse(TEST_URI_V1),
      );
      expect(parsed.protocol, 'wc');
      expect(parsed.version, URIVersion.v1);
      expect(parsed.topic,
          '7f6e504bfad60b485450578e05678ed3e8e8c4751d3c6160be17160d63ec90f9');
      expect(parsed.v1Data!.key, 'abc');
      expect(parsed.v1Data!.bridge, 'xyz');
    });
  });
}
