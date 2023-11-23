// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trening _$TreningFromJson(Map<String, dynamic> json) => Trening(
      json['id'] as int?,
      json['naziv'] as String?,
    )
      ..opis = json['opis'] as String?
      ..trajanje = json['trajanje'] as int?;

Map<String, dynamic> _$TreningToJson(Trening instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'trajanje': instance.trajanje,
    };
