import 'dart:io';

class WCSampleWallets {
  static List<Map<String, dynamic>> sampleWalletsInternal() => [
        {
          'name': 'Swift Wallet',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'schema': 'walletapp://',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal': 'https://lab.web3modal.com/wallet',
        },
        {
          'name': 'Flutter Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567895',
          'schema': 'wcflutterwallet-internal://',
          'bundleId': 'com.walletconnect.flutterwallet.internal',
          'universal':
              'https://dev.lab.web3modal.com/flutter_walletkit_internal',
        },
        {
          'name': 'RN Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '1234567890123456789012345678922',
          'schema': 'rn-web3wallet://wc',
          'bundleId': 'com.walletconnect.web3wallet.rnsample.internal',
          'universal': 'https://lab.web3modal.com/rn_walletkit',
        },
        {
          'name': 'Kotlin Wallet (Internal)',
          'platform': ['android'],
          'id': '123456789012345678901234567894',
          'schema': 'kotlin-web3wallet://wc',
          'bundleId': 'com.walletconnect.sample.wallet.internal',
          'universal':
              'https://web3modal-laboratory-git-chore-kotlin-assetlinks-walletconnect1.vercel.app/wallet_internal',
        },
      ];

  static List<Map<String, dynamic>> sampleWalletsProduction() => [
        {
          'name': 'Swift Wallet',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'schema': 'walletapp://',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal': 'https://lab.web3modal.com/wallet',
        },
        {
          'name': 'Flutter Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567891',
          'schema': 'wcflutterwallet://',
          'bundleId': 'com.walletconnect.flutterwallet',
          'universal': 'https://lab.web3modal.com/flutter_walletkit',
        },
        {
          'name': 'RN Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567892',
          'schema': 'rn-web3wallet://wc',
          'bundleId': 'com.walletconnect.web3wallet.rnsample',
          'universal': 'https://lab.web3modal.com/rn_walletkit',
        },
        {
          'name': 'Kotlin Wallet',
          'platform': ['android'],
          'id': '123456789012345678901234567893',
          'schema': 'kotlin-web3wallet://wc',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal':
              'https://web3modal-laboratory-git-chore-kotlin-assetlinks-walletconnect1.vercel.app/wallet_release',
        },
      ];

  static List<Map<String, dynamic>> getSampleWallets() {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    flavor = flavor.replaceAll('-production', '');
    if (flavor.isNotEmpty) {
      return sampleWalletsInternal().where((e) {
        return (e['platform'] as List<String>)
            .contains(Platform.operatingSystem);
      }).toList();
    }
    return sampleWalletsProduction().where((e) {
      return (e['platform'] as List<String>).contains(Platform.operatingSystem);
    }).toList();
  }
}
