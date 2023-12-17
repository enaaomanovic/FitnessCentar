
import 'package:json_annotation/json_annotation.dart';

part 'pregledaneNovosti.g.dart';

@JsonSerializable()

class PregledaneNovosti{
int? id;
int? novostId;
int? korisnikId;
  

 PregledaneNovosti(this.id,this.novostId,this.korisnikId);

  factory PregledaneNovosti.fromJson(Map<String, dynamic> json) =>
      _$PregledaneNovostiFromJson(json);

  Map<String, dynamic> toJson() => _$PregledaneNovostiToJson(this);

}