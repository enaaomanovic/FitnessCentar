// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'napredak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Napredak _$NapredakFromJson(Map<String, dynamic> json) => Napredak(
      json['id'] as int?,
      json['korisnikId'] as int?,
      json['datumMjerenja'] == null
          ? null
          : DateTime.parse(json['datumMjerenja'] as String),
      (json['tezina'] as num?)?.toDouble(),
      (json['visina'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NapredakToJson(Napredak instance) => <String, dynamic>{
      'id': instance.id,
      'korisnikId': instance.korisnikId,
      'datumMjerenja': instance.datumMjerenja?.toIso8601String(),
      'tezina': instance.tezina,
      'visina': instance.visina,
    };
