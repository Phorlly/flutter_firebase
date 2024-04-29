// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:flutter_laravel/back-end/controllers/globals.dart';

// class AuthController {
//   //==================Register==================================//
//   static Future<http.Response> register(
//       String name, String email, String password) async {
//     var data = {"name": name, "email": email, "password": password};
//     var body = json.encode(data);
//     var url = Uri.parse("$baseUrl/auth/register");
//     var response = await http.post(url, headers: headers, body: body);
//     log(response.body);
//     return response;
//   }

// //======================Login====================================//
//   static Future<http.Response> login(String email, String password) async {
//     var data = {"email": email, "password": password};
//     var body = jsonEncode(data);
//     var url = Uri.parse("$baseUrl/auth/login");
//     var response = await http.post(url, headers: headers, body: body);
//     log(response.body);
//     return response;
//   }
// }
