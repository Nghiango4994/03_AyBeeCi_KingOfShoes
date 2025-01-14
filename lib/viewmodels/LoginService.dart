import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginservice {
  String url = Providers.Url; // Thay đổi IP nếu cần

  static Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    // Hiển thị dialog thông báo đang đăng nhập
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đang đăng nhập...'),
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Vui lòng chờ'),
            ],
          ),
        );
      },
    );

    final url = Uri.parse('${Providers.Url}/thong-tin/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'mat_khau': password}),
    );

    Navigator.of(context).pop(); // Đóng dialog

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Lưu thông tin người dùng và token vào local
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(data['user']));
      await prefs.setString('token', data['token']);

      // Chuyển trang đến Home_Screen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Home_Screen()));
      return data;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
