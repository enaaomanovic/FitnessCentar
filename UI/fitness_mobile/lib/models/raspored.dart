
import 'package:json_annotation/json_annotation.dart';

part 'raspored.g.dart';

@JsonSerializable()

class Raspored{
int? id;
DateTime? datumPocetka;
DateTime? datumZavrsetka;
int? trenerId;
int? treningId;
int? aktivnostId;
int? dan;

 Raspored(this.id,this.datumPocetka,this.datumZavrsetka,this.aktivnostId,this.trenerId,this.treningId,this.dan);




  factory Raspored.fromJson(Map<String, dynamic> json) =>
      _$RasporedFromJson(json);

  Map<String, dynamic> toJson() => _$RasporedToJson(this);

}