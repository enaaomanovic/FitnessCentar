// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentIntent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    PaymentIntent(
      json['id'] as String?,
      json['clientSecret'] as String?,
    );

Map<String, dynamic> _$PaymentIntentToJson(PaymentIntent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientSecret': instance.clientSecret,
    };
