import 'package:json_annotation/json_annotation.dart';

part 'paymentIntent.g.dart';

@JsonSerializable()
class PaymentIntent {
  String? id;
  String? clientSecret;
 

   PaymentIntent(this.id,this.clientSecret);


  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentToJson(this);
}