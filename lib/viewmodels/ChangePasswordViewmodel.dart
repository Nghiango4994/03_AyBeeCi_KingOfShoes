import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class ChangePasswordViewmodel {
  Future<ThongTin> changePassword(String idkhachhang, String matkhau) async {
    final url =
        Uri.parse('${Providers.Url}/thong-tin/$idkhachhang/forgot-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'idkhachhang': idkhachhang,
        'mat_khau': matkhau,
      }),
    );
    print(idkhachhang);
    print(matkhau);
    print(response.body);
    if (response.statusCode == 200) {
      return ThongTin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to change password: ${response.body}');
    }
  }
}
