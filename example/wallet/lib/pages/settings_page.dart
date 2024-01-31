import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/custom_button.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/recover_from_seed.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('eip155:1');
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              'Account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: StyleConstants.lightGray,
              borderRadius: BorderRadius.circular(
                StyleConstants.linear16,
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'CAIP-10',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.copy,
                      size: 14.0,
                    ),
                  ],
                ),
                Text(
                  'eip155:1:${chainKeys.first.address}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            decoration: BoxDecoration(
              color: StyleConstants.lightGray,
              borderRadius: BorderRadius.circular(
                StyleConstants.linear16,
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Private key',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.copy,
                      size: 14.0,
                    ),
                  ],
                ),
                Text(
                  chainKeys.first.privateKey,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            decoration: BoxDecoration(
              color: StyleConstants.lightGray,
              borderRadius: BorderRadius.circular(
                StyleConstants.linear16,
              ),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Public key',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.copy,
                      size: 14.0,
                    ),
                  ],
                ),
                Text(
                  chainKeys.first.publicKey,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              CustomButton(
                onTap: () async {
                  final mnemonic =
                      await GetIt.I<IBottomSheetService>().queueBottomSheet(
                    widget: RecoverFromSeed(),
                  );
                  if (mnemonic is String) {
                    debugPrint(mnemonic);
                    await keysService.restoreWallet(mnemonic: mnemonic);
                    setState(() {});
                  }
                },
                child: const Center(
                  child: Text(
                    'Import account',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 12.0),
          // Row(
          //   children: [
          //     CustomButton(
          //       type: CustomButtonType.normal,
          //       onTap: () async {
          //         await keysService.createWallet();
          //         setState(() {});
          //       },
          //       child: const Center(
          //         child: Text(
          //           'Restart account',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              CustomButton(
                type: CustomButtonType.invalid,
                onTap: () async {
                  await keysService.createWallet();
                  setState(() {});
                },
                child: const Center(
                  child: Text(
                    'Delete and create new',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
