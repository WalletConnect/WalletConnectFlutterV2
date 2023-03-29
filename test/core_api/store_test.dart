import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/shared_prefs_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Store', () {
    late IStore store;

    setUp(() async {
      store = SharedPrefsStores(
        memoryStore: true,
      );
      await store.init();
    });

    group('Generic', () {
      late IGenericStore<String> genericStore;

      setUp(() async {
        genericStore = GenericStore(
          storage: store,
          context: 'keychain',
          version: 'swag',
          fromJson: (value) => value as String,
        );
        await genericStore.init();
      });

      test('has correct outcome', () async {
        Completer createComplete = Completer();
        Completer updateComplete = Completer();
        Completer deleteComplete = Completer();
        Completer syncComplete = Completer();
        genericStore.onCreate.subscribe((args) {
          createComplete.complete();
        });
        genericStore.onUpdate.subscribe((args) {
          updateComplete.complete();
        });
        genericStore.onDelete.subscribe((args) {
          deleteComplete.complete();
        });
        genericStore.onSync.subscribe((args) {
          syncComplete.complete();
        });

        expect(genericStore.get('key'), null);
        expect(genericStore.has('key'), false);
        await genericStore.set('key', 'value');
        await createComplete.future;
        await syncComplete.future;
        expect(genericStore.get('key'), 'value');
        expect(genericStore.has('key'), true);
        expect(genericStore.getAll(), ['value']);

        genericStore.onCreate.unsubscribeAll();
        syncComplete = Completer();

        await genericStore.set('key', 'value2');
        await updateComplete.future;
        await syncComplete.future;
        expect(genericStore.get('key'), 'value2');
        expect(genericStore.getAll(), ['value2']);

        genericStore.onUpdate.unsubscribeAll();
        syncComplete = Completer();

        await genericStore.delete('key');
        await deleteComplete.future;
        await syncComplete.future;
        expect(genericStore.get('key'), null);
        expect(genericStore.has('key'), false);

        genericStore.onDelete.unsubscribeAll();
        genericStore.onSync.unsubscribeAll();
      });

      test('restores properly', () async {
        store = SharedPrefsStores(
          defaultValue: {
            '${WalletConnectConstants.CORE_STORAGE_PREFIX}swag//keychain': {
              'key': 'value',
            },
          },
          memoryStore: true,
        );
        await store.init();
        genericStore = GenericStore(
          storage: store,
          context: 'keychain',
          version: 'swag',
          fromJson: (value) => value as String,
        );
        await genericStore.init();

        expect(genericStore.get('key'), 'value');
      });
    });

    group('special stores', () {
      test('message tracker', () async {
        IMessageTracker messageTracker = MessageTracker(
          storage: store,
          context: 'messageTracker',
          version: 'swag',
          fromJson: (dynamic value) {
            return WalletConnectUtils.convertMapTo<String>(value);
          },
        );
        await messageTracker.init();

        expect(messageTracker.messageIsRecorded('test', 'message'), false);

        Completer createComplete = Completer();
        messageTracker.onCreate.subscribe((args) {
          createComplete.complete();
        });

        await messageTracker.recordMessageEvent('test', 'message');
        await createComplete.future;

        expect(
          messageTracker.get('test'),
          {
            'ab530a13e45914982b79f9b7e3fba994cfd1f3fb22f71cea1afbf02b460c6d1d':
                'message',
          },
        );

        expect(messageTracker.messageIsRecorded('test', 'message'), true);
      });

      test('json rpc store', () async {
        IJsonRpcHistory specialStore = JsonRpcHistory(
          storage: store,
          context: 'specialStore',
          version: 'swag',
          fromJson: (dynamic value) {
            return JsonRpcRecord.fromJson(value);
          },
        );
        await specialStore.init();

        await specialStore.set(
          '1',
          JsonRpcRecord(
            id: 1,
            topic: 'test',
            method: 'method',
            params: [],
            expiry: 0,
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

        await specialStore.resolve(
          {
            'id': 1,
            'result': 'result',
          },
        );

        await updateComplete.future;
        await syncComplete.future;

        expect(
          specialStore.get('1')!.response,
          'result',
        );
      });

      test('pairing store', () async {
        IPairingStore specialStore = PairingStore(
          storage: store,
          context: 'specialStore',
          version: 'swag',
          fromJson: (dynamic value) {
            return PairingInfo.fromJson(value);
          },
        );
        await specialStore.init();

        await specialStore.set(
          '1',
          JsonRpcRecord(
            id: 1,
            topic: 'test',
            method: 'method',
            params: [],
            expiry: 1,
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

        await specialStore.resolve(
          {
            'id': 1,
            'result': 'result',
          },
        );

        await updateComplete.future;
        await syncComplete.future;

        expect(
          specialStore.get('1')!.response,
          'result',
        );
      });
    });
  });
}
