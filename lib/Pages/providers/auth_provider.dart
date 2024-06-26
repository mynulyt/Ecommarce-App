import 'dart:convert';

import 'package:ecommarce/DataSources/token_datasource.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  bool hasEror = false;
  String? errorMassege;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    hasEror = false;
    notifyListeners();

    http.Response response = await http.post(
        Uri.parse("https://fakestoreapi.com/auth/login"),
        body: {"username": username, "password": password});
    if (response.statusCode == 200) {
      //successful log
      print(response.body);
      String token = jsonDecode(response.body)["token"];

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      TokenDataSource tokenDataSource = TokenDataSource(sharedPreferences);
      return await tokenDataSource.save(token);
    } else {
      //field login
      print("Login Field");
      hasEror = true;
      errorMassege = "Failed to Login";
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    TokenDataSource tokenDataSource = TokenDataSource(sharedPreferences);
    return await tokenDataSource.delete();
  }
}
