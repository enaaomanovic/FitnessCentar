import 'dart:convert';

import 'package:fitness_mobile/models/aktivnosti.dart';
import 'package:fitness_mobile/models/paymentIntent.dart';
import 'package:fitness_mobile/providers/base_provider.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class PaymentIntentProvider extends BaseProvider<PaymentIntent> {
  PaymentIntentProvider():super("PaymentIntent");




 Future<dynamic> createPaymentIntent(dynamic request) async {
    var url = super.GetFull();
    url+="/createPaymentIntent";
    var uri = Uri.parse(url);
    var headers = createHeaders();
   
    var jsonRequest = jsonEncode(request);
    print("json $jsonRequest");
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
     print("uslo u if");
      var data = jsonDecode(response.body);
      print(data);
      return fromJson(data);
    } else {
      
      throw new Exception("Unknown error");
    }
    
  }




  @override
  PaymentIntent fromJson(data) {
    // TODO: implement fromJson
    return PaymentIntent.fromJson(data);
  }

  
}