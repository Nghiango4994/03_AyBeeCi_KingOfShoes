import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/QuanLyDonHang.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
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
      print('Response data: $data'); // In ra dữ liệu phản hồi

      // Kiểm tra trường isAdmin trong dữ liệu trả về
      if (data['user']['isAdmin'] == 1) {
        // Nếu isAdmin là 1, chuyển đến trang QuanLy
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => QuanLyDonHangScreen()));
      } else {
        // Nếu isAdmin không phải là 1, quay lại trang Home
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home_Screen()));
      }

      // Lưu thông tin người dùng và token vào local
      await saveUserData(data['user']);

      return data;
    } else {
      // Hiển thị thông báo lỗi nếu đăng nhập không thành công
      print('Error response: ${response.body}'); // In ra phản hồi lỗi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Tài khoản hoặc mật khẩu không đúng'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      throw Exception('Failed to login: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      return jsonDecode(userJson);
    }
    return null; // Trả về null nếu không có dữ liệu
  }

  static Future<void> saveUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user));
  }

  // Hàm xóa dữ liệu người dùng và token
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user'); // Xóa thông tin người dùng
    await prefs.remove('token'); // Xóa token
    print('User data cleared'); // In ra thông báo xóa dữ liệu
  }
}
