// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odgovoriNaKomentare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OdgovoriNaKomentare _$OdgovoriNaKomentareFromJson(Map<String, dynamic> json) =>
    OdgovoriNaKomentare(
      json['id'] as int?,
      json['komentarId'] as int?,
      json['trenerId'] as int?,
      json['tekst'] as String?,
      json['datumOdgovora'] == null
          ? null
          : DateTime.parse(json['datumOdgovora'] as String),
    );
    

Map<String, dynamic> _$OdgovoriNaKomentareToJson(
        OdgovoriNaKomentare instance) =>
    <String, dynamic>{
      'id': instance.id,
      'komentarId': instance.komentarId,
      'trenerId': instance.trenerId,
      'tekst': instance.tekst,
      'datumOdgovora': instance.datumOdgovora?.toIso8601String(),
    };
