import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class Loginservice {
  String url = Providers.Url; // Thay đổi IP nếu cần

  static Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    // Hiển thị dialog thông báo đang đăng nhập
    showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng bằng cách chạm ra ngoài
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

    // Đóng dialog sau khi có phản hồi từ server
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Thông tin người dùng và token
      // Chuyển trang đến Home_Screen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Home_Screen()));
      return data;
    } else {
      // Xử lý lỗi nếu không thành công
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
