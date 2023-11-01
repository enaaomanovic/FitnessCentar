// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      json['id'] as int?,
      json['korisnikId'] as int?,
      json['rasporedID'] as int?,
      json['status'] as String?,
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'id': instance.id,
      'korisnikId': instance.korisnikId,
      'rasporedID': instance.rasporedID,
      'status': instance.status,
    };
