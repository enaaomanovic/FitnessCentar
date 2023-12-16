// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommender _$RecommenderFromJson(Map<String, dynamic> json) => Recommender(
      json['id'] as int?,
      json['novostId'] as int?,
      json['coNovostId1'] as int?,
      json['coNovostId2'] as int?,
      json['coNovostId3'] as int?,
    );

Map<String, dynamic> _$RecommenderToJson(Recommender instance) =>
    <String, dynamic>{
      'id': instance.id,
      'novostId': instance.novostId,
      'coNovostId1': instance.coNovostId1,
      'coNovostId2': instance.coNovostId2,
      'coNovostId3': instance.coNovostId3,
    };
