import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class RegisterService {
  static const String baseUrl = Providers.Url; // Thay đổi IP nếu cần

  static Future<void> register(
      String name, String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/thong-tin/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ten': name,
        'email': email,
        'mat_khau': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Đăng ký thành công
      //final data = jsonDecode(response.body);
      // Chuyển hướng đến màn hình đăng nhập
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login_Screen()),
      );
    } else {
      // Xử lý lỗi
      throw Exception('Failed to register: ${response.body}');
    }
  }
}
