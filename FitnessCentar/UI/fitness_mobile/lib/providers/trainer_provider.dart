import 'dart:convert';


import 'package:fitness_mobile/models/trener.dart';
import 'package:fitness_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TrainerProvider extends BaseProvider<Trener> {
  TrainerProvider():super("Novosti");

  @override
  Trener fromJson(data) {
    // TODO: implement fromJson
    return Trener.fromJson(data);
  }
  
}