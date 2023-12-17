import 'dart:convert';

import 'package:fitness_mobile/models/rezervacija.dart';
import 'package:fitness_mobile/providers/base_provider.dart';
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