import 'package:json_annotation/json_annotation.dart';

part 'korisnici.g.dart';

@JsonSerializable()
class Korisnici{
int? id;
String? ime;
String? prezime;
String? korisnickoIme;
String? email;
String? telefon;
DateTime? datumRegistracije;
DateTime? datumRodjenja;
String? pol;
double? tezina;
double? visina;
String? slika;
String? lozinka;

  Korisnici(this.id,this.ime,this.prezime,this.korisnickoIme,this.email,this.telefon,this.datumRegistracije,this.datumRodjenja,this.pol,this.tezina,this.visina,this.slika,this.lozinka);




  factory Korisnici.fromJson(Map<String, dynamic> json) =>
      _$KorisniciFromJson(json);

  Map<String, dynamic> toJson() => _$KorisniciToJson(this);


}
