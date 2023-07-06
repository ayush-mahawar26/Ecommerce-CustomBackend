import 'dart:convert';

import 'package:ecommerce_custom_backend/constants/global.variable.dart';
import 'package:ecommerce_custom_backend/models/usermodel.dart';
import 'package:ecommerce_custom_backend/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String url = GlobalVariables().baseUrl;

  // SignIn User
  Future<Map<dynamic, dynamic>?> signInUser(String email, String pass) async {
    Uri uri = Uri.parse("$url/signin");
    try {
      http.Response signInResponse = await http.post(uri,
          body: jsonEncode({"email": email, "password": pass}),
          headers: GlobalVariables().headers);
      Map<dynamic, dynamic> res = jsonDecode(signInResponse.body);

      return res;
    } catch (err) {
      return null;
    }
  }

  signupUser(String username, String email, String pass, String type) async {
    Uri uri = Uri.parse("$url/signup");
    try {
      http.Response signUpResponse = await http.post(uri,
          body: jsonEncode({
            "username": username,
            "email": email,
            "password": pass,
            "type": type
          }),
          headers: GlobalVariables().headers);
      Map<dynamic, dynamic> res = jsonDecode(signUpResponse.body);

      return res;
    } catch (e) {
      return null;
    }
  }

  getTheUser(String token) async {
    try {
      http.Response user = await http.get(Uri.parse("$url/"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'jwt': token
      });
      Map jsonUser = await jsonDecode(user.body);

      print(jsonUser);

      UserModel userModel = UserModel.fromJson(jsonUser);
      return userModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
