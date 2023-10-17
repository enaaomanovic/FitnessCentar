// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novosti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novosti _$NovostiFromJson(Map<String, dynamic> json) => Novosti(
      json['id'] as int?,
      json['naslov'] as String?,
      json['tekst'] as String?,
      json['DatumObjave'] == null
          ? null
          : DateTime.parse(json['datumObjave'] as String),
      json['autorId'] as int?,
    );

Map<String, dynamic> _$NovostiToJson(Novosti instance) => <String, dynamic>{
      'id': instance.id,
      'naslov': instance.naslov,
      'tekst': instance.tekst,
      'datumObjave': instance.datumObjave?.toIso8601String(),
      'AutorId': instance.autorId,
    };
