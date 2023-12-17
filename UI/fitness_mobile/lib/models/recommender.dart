
import 'package:json_annotation/json_annotation.dart';

part 'recommender.g.dart';

@JsonSerializable()

class Recommender{
int? id;
int? novostId;
int? coNovostId1;
int? coNovostId2;
int? coNovostId3;


 Recommender(this.id,this.novostId,this.coNovostId1,this.coNovostId2,this.coNovostId3);

  factory Recommender.fromJson(Map<String, dynamic> json) =>
      _$RecommenderFromJson(json);

  Map<String, dynamic> toJson() => _$RecommenderToJson(this);

}