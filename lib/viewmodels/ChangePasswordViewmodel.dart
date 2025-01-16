import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class ChangePasswordViewmodel {
  Future<ThongTin> changePassword(
      String idKhachHang, String matKhauCu, String matKhauMoi) async {
    final url =
        Uri.parse('${Providers.Url}/thong-tin/$idKhachHang/forgot-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_khach_hang': idKhachHang, // Gửi id khách hàng
        'mat_khau': matKhauCu, // Gửi mật khẩu cũ
        'mat_khau_moi': matKhauMoi, // Gửi mật khẩu mới
      }),
    );

    if (response.statusCode == 200) {
      return ThongTin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to change password');
    }
  }
}
