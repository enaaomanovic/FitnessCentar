import 'dart:convert';
import 'package:fitness_admin/models/rezervacija.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/providers/base_provider.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ReservationProvider extends BaseProvider<Rezervacija> {
  ReservationProvider() : super("Rezervacija");

  @override
  Rezervacija fromJson(data) {
    // TODO: implement fromJson
    return Rezervacija.fromJson(data);
  }
}
