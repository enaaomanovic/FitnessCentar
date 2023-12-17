import 'dart:convert';


import 'package:fitness_admin/models/napredak.dart';
import 'package:fitness_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ProgressProvider extends BaseProvider<Napredak> {
  ProgressProvider() : super("Napredak");

  @override
  Napredak fromJson(data) {
    // TODO: implement fromJson
    return Napredak.fromJson(data);
  }
}