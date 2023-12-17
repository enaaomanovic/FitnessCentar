
import 'package:json_annotation/json_annotation.dart';

part 'placanja.g.dart';

@JsonSerializable()
class Placanja {
  int? id;
  int? korisnikId;
  DateTime? datumPlacanja;
  double? iznos;

   Placanja(this.id,this.korisnikId,this.datumPlacanja,this.iznos);


  factory Placanja.fromJson(Map<String, dynamic> json) =>
      _$PlacanjaFromJson(json);

  Map<String, dynamic> toJson() => _$PlacanjaToJson(this);
}