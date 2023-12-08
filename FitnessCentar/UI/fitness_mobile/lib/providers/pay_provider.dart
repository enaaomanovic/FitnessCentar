import 'dart:convert';


import 'package:fitness_mobile/models/placanja.dart';
import 'package:fitness_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PayProvider extends BaseProvider<Placanja> {
  PayProvider():super("Placanja");
 double _amountToPay = 0.0;

  double get amountToPay => _amountToPay;

  void setAmountToPay(double amount) {
    _amountToPay = amount;
    notifyListeners();
  }
 
  @override
  Placanja fromJson(data) {
    // TODO: implement fromJson
    return Placanja.fromJson(data);
  }
  
}