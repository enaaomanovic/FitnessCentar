import 'package:json_annotation/json_annotation.dart';

part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija{
int? id;
int? korisnikId;
int? rasporedID;
String? status;


  Rezervacija(this.id,this.korisnikId,this.rasporedID,this.status);

  factory Rezervacija.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);

}