// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentari.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Komentari _$KomentariFromJson(Map<String, dynamic> json) => Komentari(
      json['id'] as int?,
      json['korisnikId'] as int?,
      json['novostId'] as int?,
      json['tekst'] as String?,
      json['datumKomentara'] == null
          ? null
          : DateTime.parse(json['datumKomentara'] as String),
    );

Map<String, dynamic> _$KomentariToJson(Komentari instance) => <String, dynamic>{
      'id': instance.id,
      'novostId': instance.novostId,
      'korisnikId': instance.korisnikId,
      'tekst': instance.tekst,
      'datumKomentara': instance.datumKomentara?.toIso8601String(),
    };
