

import 'package:json_annotation/json_annotation.dart';

part 'komentari.g.dart';

@JsonSerializable()
class Komentari{
int? id;
int? novostId;
int? korisnikId;
String? tekst;
DateTime? datumKomentara;


Komentari(this.id,this.korisnikId,this.novostId,this.tekst,this.datumKomentara);

  factory Komentari.fromJson(Map<String, dynamic> json) =>
      _$KomentariFromJson(json);

  Map<String, dynamic> toJson() => _$KomentariToJson(this);


}

