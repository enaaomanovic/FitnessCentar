


import 'package:json_annotation/json_annotation.dart';

part 'napredak.g.dart';

@JsonSerializable()
class Napredak{
int? id;
int? korisnikId;
DateTime? datumMjerenja;
double? tezina;
double? visina;


  Napredak(this.id,this.korisnikId,this.datumMjerenja,this.tezina,this.visina, );




  factory Napredak.fromJson(Map<String, dynamic> json) =>
      _$NapredakFromJson(json);

  Map<String, dynamic> toJson() => _$NapredakToJson(this);


}

