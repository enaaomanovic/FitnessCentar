
import 'dart:convert';
import 'package:fitness_admin/utils/util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class UserProvider with ChangeNotifier{

static String? _baseUrl;
String _endopint="Korisnici";

UserProvider(){
  _baseUrl= const String.fromEnvironment("baseUrl",defaultValue: "http://localhost:5266/");
}
 
Future<dynamic>get() async{
var url= "$_baseUrl$_endopint";
var uri=Uri.parse(url);
var headers=createHeaders();
var response= await http.get(uri,headers:headers);


  if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw new Exception("Unknown error");
    }
}
  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      print(response.body);
      throw new Exception("Something bad happened please try again");
    }
  }

Map<String,String> createHeaders(){
  String username= Authorization.username ?? "";
  String password=Authorization.password ?? "";
 

  print("kredencijali $username $password");

String basicAuth= "Basic ${base64Encode(utf8.encode('$username:$password'))}";

  var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
     
    return headers;
}

}