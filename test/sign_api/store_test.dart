import 'dart:async';

import 'package:test/test.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/memory_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sessions.dart';

import '../auth_api/utils/engine_constants.dart';

void main() {
  group('Store', () {
    late IStore<Map<String, dynamic>> store;

    setUp(() async {
      store = MemoryStore();
      await store.init();
    });

    group('special stores', () {
      test('sessions', () async {
        ISessions specialStore = Sessions(
          storage: store,
          context: 'messageTracker',
          version: 'swag',
          fromJson: (dynamic value) {
            return SessionData.fromJson(value);
          },
        );

        await specialStore.init();

        await specialStore.set(
          '1',
          SessionData(
            topic: '1',
            pairingTopic: '2',
            relay: Relay('irn'),
            expiry: -1,
            acknowledged: false,
            controller: 'controller',
            namespaces: {
              'eth': const Namespace(accounts: [], methods: [], events: []),
            },
            self: TEST_CONNECTION_METADATA_REQUESTER,
            peer: TEST_CONNECTION_METADATA_REQUESTER,
          ),
        );

        Completer updateComplete = Completer();
        Completer syncComplete = Completer();
        specialStore.onUpdate.subscribe((args) {
          updateComplete.complete();
        });
        specialStore.onSync.subscribe((args) {
          syncComplete.complete();
        });

        expect(
          specialStore.get('1')!.expiry,
          -1,
        );

        await specialStore.update(
          '1',
          expiry: 2,
        );

        await updateComplete.future;
        await syncComplete.future;

        expect(
          specialStore.get('1')!.expiry,
          2,
        );
      });
    });
  });
}
