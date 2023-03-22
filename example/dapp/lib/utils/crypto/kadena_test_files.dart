import 'package:json_annotation/json_annotation.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

part 'kadena_test_files.g.dart';

@JsonSerializable(includeIfNull: false)
class SignRequest {
  /// The pact code to be executed.
  String code;
  String pactCode;

  /// The JSON data available during the execution of the code
  /// Accessible using built-in functions like `read-msg`
  Map<String, dynamic> data;
  Map<String, dynamic> envData;

  /// The account that will pay for the transaction's gas.
  String sender;

  /// mainnet01, testnet04
  String networkId;

  /// The chain the transaction will be executed on.
  /// 0, 1, 2...
  String chainId;

  /// The maximum amount of gas to be used for the transaction.
  int gasLimit;

  /// The price of gas to be used for the transaction.
  /// Generally something like 1e-5 or 1e-8
  double gasPrice;

  /// The public key that will sign the transaction.
  String signingPubKey;

  /// Time to live in seconds
  int ttl;

  /// The role and descriptiong are displayed to the user when signing
  List<DappCapp> caps;

  SignRequest({
    required this.code,
    this.data = const {},
    required this.sender,
    required this.networkId,
    required this.chainId,
    this.gasLimit = 2500,
    this.gasPrice = 1e-8,
    required this.signingPubKey,
    this.ttl = 600,
    this.caps = const <DappCapp>[],
  })  : pactCode = code,
        envData = data;

  factory SignRequest.fromJson(Map<String, dynamic> json) =>
      _$SignRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignRequestToJson(this);
}
