import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kingofshoes/views/Home_Screen.dart';

class Loginservice {
  static const String baseUrl =
      "http://10.0.2.2:8080/api"; // Thay đổi IP nếu cần

  static Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/thong-tin/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'mat_khau': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Thông tin người dùng và token
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Home_Screen()));
      return data;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
