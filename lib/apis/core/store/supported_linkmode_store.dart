import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

abstract class ILinkModeStore extends IGenericStore<List<String>> {
  Future<void> update(String url);
  List<String> getList();
}

class LinkModeStore extends GenericStore<List<String>>
    implements ILinkModeStore {
  //
  LinkModeStore({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  static const _key = WalletConnectConstants.WALLETCONNECT_LINK_MODE_APPS;

  @override
  Future<void> update(String url) async {
    checkInitialized();

    final currentList = getList();
    if (!currentList.contains(url)) {
      final newList = List<String>.from([...currentList, url]);
      await storage.set(_key, {_key: newList});
    }
  }

  @override
  List<String> getList() {
    checkInitialized();

    if (storage.has(_key)) {
      final storageValue = storage.get(_key)!;
      if (storageValue.keys.contains(_key)) {
        final currentList = (storageValue[_key] as List);
        return currentList.map((e) => '$e').toList();
      }
    }
    return [];
  }
}
