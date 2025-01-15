import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/thong_tin.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

Future<List<ThongTin>> fetchInfo() async {
  final String url = Providers.Url; // Lấy URL từ Provider

  try {
    final response = await http.get(Uri.parse('$url/thong-tin'));

    if (response.statusCode == 200) {
      // Giải mã dữ liệu trả về là một mảng (List<dynamic>)
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => ThongTin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load info: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load info: $e');
  }
}
