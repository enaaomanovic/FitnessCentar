import 'dart:convert';
import 'package:fitness_admin/models/novosti.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/providers/base_provider.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsProvider extends BaseProvider<Novosti> {
  NewsProvider():super("Novosti");

  @override
  Novosti fromJson(data) {
    // TODO: implement fromJson
    return Novosti.fromJson(data);
  }
  
}


