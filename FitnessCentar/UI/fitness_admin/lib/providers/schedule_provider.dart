import 'dart:convert';
import 'package:fitness_admin/models/raspored.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/providers/base_provider.dart';
import 'package:fitness_admin/utils/util.dart';
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
