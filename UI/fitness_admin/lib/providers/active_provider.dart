import 'dart:convert';
import 'package:fitness_admin/models/aktivnosti.dart';
import 'package:fitness_admin/models/search_result.dart';

import 'package:fitness_admin/providers/base_provider.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ActiveProvider extends BaseProvider<Aktivnosti> {
  ActiveProvider():super("Aktivnosti");


  @override
  Aktivnosti fromJson(data) {
    // TODO: implement fromJson
    return Aktivnosti.fromJson(data);
  }

  
}

