// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnici _$KorisniciFromJson(Map<String, dynamic> json) => Korisnici(
      json['id'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnickoIme'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['datumRegistracije'] == null
          ? null
          : DateTime.parse(json['datumRegistracije'] as String),
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['pol'] as String?,
      (json['tezina'] as num?)?.toDouble(),
      (json['visina'] as num?)?.toDouble(),
      json['slika'] as String?,
      json['lozinka'] as String?,
    );

Map<String, dynamic> _$KorisniciToJson(Korisnici instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'telefon': instance.telefon,
      'datumRegistracije': instance.datumRegistracije?.toIso8601String(),
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'pol': instance.pol,
      'tezina': instance.tezina,
      'visina': instance.visina,
      'slika': instance.slika,
      'lozinka': instance.lozinka,
    };
