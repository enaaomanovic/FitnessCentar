import 'dart:convert';

import 'package:fitness_mobile/models/komentari.dart';

import 'package:fitness_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CommentProvider extends BaseProvider<Komentari> {
  CommentProvider():super("Komentari");

  @override
  Komentari fromJson(data) {
    // TODO: implement fromJson
    return Komentari.fromJson(data);
  }
  
}