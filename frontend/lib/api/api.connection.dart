import 'dart:convert';

import 'package:http/http.dart' as http;

class ConnectApi {
  final client = http.Client();

  String baseUrl = "http://192.168.143.1:8080";

  final header = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Future loginUser(String email, String pass) async {
    final Uri uri = Uri.parse(baseUrl + "/signin");

    http.Response res = await client.post(uri,
        body: jsonEncode({"name": "ayush", "email": email, "password": pass}),
        headers: header);

    return res.body;
  }

  Future createUser(String email, String pass) async {
    final Uri uri = Uri.parse(baseUrl + "/register");

    http.Response res = await client.post(uri,
        body: jsonEncode({"name": "ayush", "email": email, "password": pass}),
        headers: header);

    return res.body;
  }
}
