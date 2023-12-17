import 'package:json_annotation/json_annotation.dart';

part 'trener.g.dart';

@JsonSerializable()
class Trener{
int? id;
String? specijalnost;


  Trener(this.id,this.specijalnost);


  factory Trener.fromJson(Map<String, dynamic> json) =>
      _$TrenerFromJson(json);

  Map<String, dynamic> toJson() => _$TrenerToJson(this);


}
