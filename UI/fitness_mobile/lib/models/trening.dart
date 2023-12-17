import 'package:json_annotation/json_annotation.dart';

part 'trening.g.dart';

@JsonSerializable()
class Trening {
  int? id;

  String? naziv;

  String? opis;

  int? trajanje;

  Trening(this.id, this.naziv);

  factory Trening.fromJson(Map<String, dynamic> json) =>
      _$TreningFromJson(json);

  Map<String, dynamic> toJson() => _$TreningToJson(this);
}
