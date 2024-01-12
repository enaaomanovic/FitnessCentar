import 'dart:convert';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/providers/base_provider.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class UserProvider extends BaseProvider<Korisnici> {
  UserProvider():super("Korisnici");

 int? _loggedInUserId; // Polje za spremanje ID-a ulogiranog korisnika
int? get loggedInUserId => _loggedInUserId;

  @override
  Korisnici fromJson(data) {
    // TODO: implement fromJson
    return Korisnici.fromJson(data);
  }
 int? currentUserId; // Dodajte varijablu za pohranu trenutnog korisnikovog ID-a

  void setCurrentUserId(int? userId) {
    currentUserId = userId;
   
    notifyListeners(); // Obavijestite slušatelje (widgete) o promjeni
  }
  
   Future<void> updateUser() async {
  
    if (currentUserId != null) {
     
      final updatedUser = await getById(currentUserId!);
  

      if (updatedUser != null) {
        notifyListeners();
      }
    }
  }

  
}






