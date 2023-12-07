import 'dart:convert';
import 'package:fitness_admin/models/odgovoriNaKomentare.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/providers/base_provider.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ReplyToCommentProvider extends BaseProvider<OdgovoriNaKomentare> {
  ReplyToCommentProvider():super("OdgovoriNaKomentare");

  @override
  OdgovoriNaKomentare fromJson(data) {
    // TODO: implement fromJson
    return OdgovoriNaKomentare.fromJson(data);
  }
  
}