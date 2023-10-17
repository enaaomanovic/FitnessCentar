import 'package:json_annotation/json_annotation.dart';

part 'novosti.g.dart';

@JsonSerializable()
class Novosti{
       int? id;
       String? naslov;
       String? tekst;
       DateTime? datumObjave;
       int? autorId;

         Novosti(this.id,this.naslov,this.tekst,this.datumObjave,this.autorId);

  factory Novosti.fromJson(Map<String, dynamic> json) =>
      _$NovostiFromJson(json);

  Map<String, dynamic> toJson() => _$NovostiToJson(this);
}

