import 'package:json_annotation/json_annotation.dart';

part 'solana_sign_transaction.g.dart';

@JsonSerializable(includeIfNull: false)
class SolanaSignTransaction {
  final String feePayer;
  final String recentBlockhash;
  final List<SolanaInstruction> instructions;

  SolanaSignTransaction({
    required this.feePayer,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory SolanaSignTransaction.fromJson(Map<String, dynamic> json) =>
      _$SolanaSignTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$SolanaSignTransactionToJson(this);

  @override
  String toString() {
    return 'SolanaSignTransaction(feePayer: $feePayer, recentBlockhash: $recentBlockhash, instructions: $instructions)';
  }
}

@JsonSerializable(includeIfNull: false)
class SolanaInstruction {
  final String programId;
  final List<SolanaKeyMetadata> keys;
  final String data;

  SolanaInstruction({
    required this.programId,
    required this.keys,
    required this.data,
  });

  factory SolanaInstruction.fromJson(Map<String, dynamic> json) =>
      _$SolanaInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$SolanaInstructionToJson(this);

  @override
  String toString() {
    return 'SolanaInstruction(programId: $programId, keys: $keys, data: $data)';
  }
}

@JsonSerializable(includeIfNull: false)
class SolanaKeyMetadata {
  final String pubkey;
  final bool isSigner;
  final bool isWritable;

  SolanaKeyMetadata({
    required this.pubkey,
    required this.isSigner,
    required this.isWritable,
  });

  factory SolanaKeyMetadata.fromJson(Map<String, dynamic> json) =>
      _$SolanaKeyMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SolanaKeyMetadataToJson(this);

  @override
  String toString() {
    return 'SolanaKeyMetadata(pubkey: $pubkey, isSigner: $isSigner, isWritable: $isWritable)';
  }
}
