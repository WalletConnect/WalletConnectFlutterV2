// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solana_sign_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolanaSignTransaction _$SolanaSignTransactionFromJson(
        Map<String, dynamic> json) =>
    SolanaSignTransaction(
      feePayer: json['feePayer'] as String,
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => SolanaInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SolanaSignTransactionToJson(
        SolanaSignTransaction instance) =>
    <String, dynamic>{
      'feePayer': instance.feePayer,
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions,
    };

SolanaInstruction _$SolanaInstructionFromJson(Map<String, dynamic> json) =>
    SolanaInstruction(
      programId: json['programId'] as String,
      keys: (json['keys'] as List<dynamic>)
          .map((e) => SolanaKeyMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: json['data'] as String,
    );

Map<String, dynamic> _$SolanaInstructionToJson(SolanaInstruction instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'keys': instance.keys,
      'data': instance.data,
    };

SolanaKeyMetadata _$SolanaKeyMetadataFromJson(Map<String, dynamic> json) =>
    SolanaKeyMetadata(
      pubkey: json['pubkey'] as String,
      isSigner: json['isSigner'] as bool,
      isWritable: json['isWritable'] as bool,
    );

Map<String, dynamic> _$SolanaKeyMetadataToJson(SolanaKeyMetadata instance) =>
    <String, dynamic>{
      'pubkey': instance.pubkey,
      'isSigner': instance.isSigner,
      'isWritable': instance.isWritable,
    };
