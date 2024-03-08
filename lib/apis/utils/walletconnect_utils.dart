import 'dart:convert';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_metadata/platform_metadata.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WalletConnectUtils {
  static bool isExpired(int expiry) {
    return DateTime.now().toUtc().compareTo(
              DateTime.fromMillisecondsSinceEpoch(
                toMilliseconds(expiry),
              ),
            ) >=
        0;
  }

  static DateTime expiryToDateTime(int expiry) {
    final milliseconds = expiry * 1000;
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  static int toMilliseconds(int seconds) {
    return seconds * 1000;
  }

  static int calculateExpiry(int offset) {
    return DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000 + offset;
  }

  static String getOS() {
    return <String>[Platform.operatingSystem, Platform.operatingSystemVersion]
        .join('-');
  }

  static Future<String> getPackageName() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  static String getId() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isLinux) {
      return 'linux';
    } else if (Platform.isMacOS) {
      return 'macos';
    } else if (Platform.isWindows) {
      return 'windows';
    } else if (kIsWeb) {
      return 'web';
    } else {
      return 'unknown';
    }
  }

  static String formatUA(
    String protocol,
    int version,
    String sdkVersion,
  ) {
    String os = getOS();
    String id = getId();
    return <String>[
      [protocol, version].join('-'),
      <String>['Flutter', sdkVersion].join('-'),
      os,
      id,
    ].join('/');
  }

  static String formatRelayRpcUrl({
    required String protocol,
    required int version,
    required String relayUrl,
    required String sdkVersion,
    required String auth,
    String? projectId,
    String? packageName,
  }) {
    final Uri uri = Uri.parse(relayUrl);
    final Map<String, String> queryParams = Uri.splitQueryString(uri.query);
    String ua = formatUA(protocol, version, sdkVersion);

    final Map<String, String> relayParams = {
      'auth': auth,
      if ((projectId ?? '').isNotEmpty) 'projectId': projectId!,
      'ua': ua,
      if ((packageName ?? '').isNotEmpty) 'origin': packageName!,
    };
    queryParams.addAll(relayParams);
    return uri.replace(queryParameters: queryParams).toString();
  }

  /// ---- URI HANDLING --- ///

  static URIParseResult parseUri(Uri uri) {
    String protocol = uri.scheme;
    String path = uri.path;
    final List<String> splitParams = path.split('@');
    if (splitParams.length == 1) {
      throw const WalletConnectError(
        code: 0,
        message: 'Invalid URI: Missing @',
      );
    }
    List<String> methods = (uri.queryParameters['methods'] ?? '')
        // Replace all the square brackets with empty string, split by comma
        .replaceAll(RegExp(r'[\[\]"]+'), '')
        .split(',');
    if (methods.length == 1 && methods[0].isEmpty) {
      methods = [];
    }
    final URIVersion? version;
    switch (splitParams[1]) {
      case '1':
        version = URIVersion.v1;
        break;
      case '2':
        version = URIVersion.v2;
        break;
      default:
        version = null;
    }
    final URIV1ParsedData? v1Data;
    final URIV2ParsedData? v2Data;
    if (version == URIVersion.v1) {
      v1Data = URIV1ParsedData(
        key: uri.queryParameters['key']!,
        bridge: uri.queryParameters['bridge']!,
      );
      v2Data = null;
    } else {
      v1Data = null;
      v2Data = URIV2ParsedData(
        symKey: uri.queryParameters['symKey']!,
        relay: Relay(
          uri.queryParameters['relay-protocol']!,
          data: uri.queryParameters.containsKey('relay-data')
              ? uri.queryParameters['relay-data']
              : null,
        ),
        methods: methods,
      );
    }

    URIParseResult ret = URIParseResult(
      protocol: protocol,
      version: version,
      topic: splitParams[0],
      v1Data: v1Data,
      v2Data: v2Data,
    );
    return ret;
  }

  static Map<String, String> formatRelayParams(
    Relay relay, {
    String delimiter = '-',
  }) {
    Map<String, String> params = {};
    params[['relay', 'protocol'].join(delimiter)] = relay.protocol;
    if (relay.data != null) {
      params[['relay', 'data'].join(delimiter)] = relay.data!;
    }
    return params;
  }

  static Uri formatUri({
    required String protocol,
    required String version,
    required String topic,
    required String symKey,
    required Relay relay,
    required List<List<String>>? methods,
  }) {
    Map<String, String> params = formatRelayParams(relay);
    params['symKey'] = symKey;
    if (methods != null) {
      params['methods'] = methods
          .map((e) => jsonEncode(e))
          .join(
            ',',
          )
          .replaceAll(
            '"',
            '',
          );
    } else {
      params['methods'] = '[]';
    }

    return Uri(
      scheme: protocol,
      path: '$topic@$version',
      queryParameters: params,
    );
  }

  static Map<String, T> convertMapTo<T>(Map<String, dynamic> inMap) {
    Map<String, T> m = {};
    for (var entry in inMap.entries) {
      m[entry.key] = entry.value as T;
    }
    return m;
  }

  static Future<String?> validateRedirect(Redirect? redirect) async {
    try {
      final metaDataValue = await PlatformMetadata.getMetaDataValue(
        'CFBundleURLTypes',
      );
      if (metaDataValue == null) {
        return 'CFBundleURLSchemes\'s key is missing on iOS\'s Info.plist.\n'
            'Check out https://docs.walletconnect.com/web3wallet/mobileLinking on how to include it';
      }
      final properties = metaDataValue as List;
      for (var prop in properties) {
        if (prop is Map && prop.keys.contains('CFBundleURLSchemes')) {
          final plistSchemas = prop['CFBundleURLSchemes'] as List;
          final nativeSchema = redirect?.native ?? '';
          final universalLink = redirect?.universal ?? '';
          if (nativeSchema.isEmpty && universalLink.isEmpty) {
            return 'No metadata.redirect object has been set\n'
                'Check out https://docs.walletconnect.com/web3wallet/wallet-usage#initialization';
          }
          if (nativeSchema.isEmpty) {
            return 'Metadata\'s native redirect value has not been set\n'
                'Check out https://docs.walletconnect.com/web3wallet/wallet-usage#initialization';
          }
          final uri = Uri.parse(nativeSchema);
          if (!plistSchemas.contains(uri.scheme)) {
            return 'Metadata\'s native redirect ($uri) is not included under CFBundleURLSchemes\'s key.\n'
                'Check out https://docs.walletconnect.com/web3wallet/mobileLinking on how to include it';
          }
        }
      }
      return null;
    } catch (e) {
      return 'Web3Wallet: failed to get iOS configuration: $e';
    }
  }
}
