import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/deep_link_handler.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

class CommonMethods {
  static void goBackToDapp(String topic, dynamic result) {
    try {
      final web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;
      final session = web3Wallet.sessions.get(topic);
      final scheme = session?.peer.metadata.redirect?.native ?? '';
      if (result is String) {
        DeepLinkHandler.goTo(scheme, modalTitle: 'Success');
      } else {
        DeepLinkHandler.goTo(
          scheme,
          modalTitle: 'Error',
          modalMessage: result.toString(),
          success: false,
        );
      }
    } catch (e) {
      debugPrint('[WALLET] ${e.toString()}');
    }
  }

  static Future<bool> requestApproval(String text, {String? title}) async {
    final bottomSheetService = GetIt.I<IBottomSheetService>();
    final WCBottomSheetResult rs = (await bottomSheetService.queueBottomSheet(
          widget: WCRequestWidget(
            child: WCConnectionWidget(
              title: 'Approve Request',
              info: [
                WCConnectionModel(
                  title: title,
                  elements: [
                    text,
                  ],
                ),
              ],
            ),
          ),
        )) ??
        WCBottomSheetResult.reject;

    return rs != WCBottomSheetResult.reject;
  }
}
