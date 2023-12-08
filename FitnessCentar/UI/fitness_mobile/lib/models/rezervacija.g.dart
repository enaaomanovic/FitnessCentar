// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      json['id'] as int?,
      json['korisnikId'] as int?,
      json['rasporedId'] as int?,
      json['status'] as String?,
      json['datumRezervacija'] == null
          ? null
          : DateTime.parse(json['datumRezervacija'] as String),
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'id': instance.id,
      'korisnikId': instance.korisnikId,
      'rasporedId': instance.rasporedId,
      'status': instance.status,
      'datumRezervacija': instance.datumRezervacija?.toIso8601String(),
    };
