import 'dart:convert';

import 'package:fitness_mobile/models/trening.dart';
import 'package:fitness_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WorkoutProvider extends BaseProvider<Trening> {
  WorkoutProvider():super("Trening");

  @override
  Trening fromJson(data) {
    // TODO: implement fromJson
    return Trening.fromJson(data);
  }
  
}