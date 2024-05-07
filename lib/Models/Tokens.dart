import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Tokens {
  String access;
  String refresh;
  
  Tokens(this.access, this.refresh);

  factory Tokens.fromJson(String jsonStr) {
    final Map<String, dynamic> map = json.decode(jsonStr);
    return Tokens(
      map['access'],
      map['refresh'],
    );
  }
  Future<String?> getToken(SharedPreferences prefs) async {
  return prefs.getString('access');
 }
 

}
