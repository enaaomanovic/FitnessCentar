
import 'dart:convert';

import 'package:flutter/cupertino.dart';


class Authorization {
  static String? username;
  static String? password;
}

Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}