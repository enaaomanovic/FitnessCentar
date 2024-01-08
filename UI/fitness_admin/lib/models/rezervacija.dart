import 'package:json_annotation/json_annotation.dart';

part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija{
int? id;
int? korisnikId;
int? rasporedId;
String? status;
DateTime? datumRezervacija;
int? placanjeId;
 bool istekla = false;



  Rezervacija(this.id,this.korisnikId,this.rasporedId,this.status,this.datumRezervacija,this.placanjeId);

  factory Rezervacija.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);

}