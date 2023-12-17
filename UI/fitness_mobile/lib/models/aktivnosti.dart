
import 'package:json_annotation/json_annotation.dart';

part 'aktivnosti.g.dart';

@JsonSerializable()

class Aktivnosti {
  int? id;
  String? naziv;


   Aktivnosti(this.id,this.naziv);


  factory Aktivnosti.fromJson(Map<String, dynamic> json) =>
      _$AktivnostiFromJson(json);

  Map<String, dynamic> toJson() => _$AktivnostiToJson(this);
}