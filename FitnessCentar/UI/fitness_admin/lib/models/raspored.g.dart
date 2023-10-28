// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raspored.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Raspored _$RasporedFromJson(Map<String, dynamic> json) => Raspored(
      json['id'] as int?,
      json['datumPocetka'] == null
          ? null
          : DateTime.parse(json['datumPocetka'] as String),
      json['datumZavrsetka'] == null
          ? null
          : DateTime.parse(json['datumZavrsetka'] as String),
      json['aktivnostId'] as int?,
      json['trenerId'] as int?,
      json['treningId'] as int?,
      json['dan'] as int?,
    );

Map<String, dynamic> _$RasporedToJson(Raspored instance) => <String, dynamic>{
      'id': instance.id,
      'datumPocetka': instance.datumPocetka?.toIso8601String(),
      'datumZavrsetka': instance.datumZavrsetka?.toIso8601String(),
      'trenerId': instance.trenerId,
      'treningId': instance.treningId,
      'aktivnostId': instance.aktivnostId,
      'dan':instance.dan,
    };
