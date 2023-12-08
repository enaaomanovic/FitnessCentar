// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placanja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Placanja _$PlacanjaFromJson(Map<String, dynamic> json) => Placanja(
      json['id'] as int?,
      json['korisnikId'] as int?,
      json['datumPlacanja'] == null
          ? null
          : DateTime.parse(json['datumPlacanja'] as String),
      (json['iznos'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PlacanjaToJson(Placanja instance) => <String, dynamic>{
      'id': instance.id,
      'korisnikId': instance.korisnikId,
      'datumPlacanja': instance.datumPlacanja?.toIso8601String(),
      'iznos': instance.iznos,
    };
