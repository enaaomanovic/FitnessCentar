import 'dart:convert';

import 'package:fitness_mobile/models/raspored.dart';
import 'package:fitness_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ScheduleProvider extends BaseProvider<Raspored> {
  ScheduleProvider():super("Raspored");

  @override
  Raspored fromJson(data) {
    // TODO: implement fromJson
    return Raspored.fromJson(data);
  }
  
}