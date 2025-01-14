import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/bien_the_san_pham.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

Future<List<BienTheSanPham>> fetchProducts() async {
  String url = Providers.Url;
  try {
    final response = await http.get(Uri.parse('${Providers.Url}/bienthe'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Lấy danh sách sản phẩm từ trường 'data'
      final List<dynamic> products = data['data'];
      // Chuyển đổi danh sách thành các đối tượng BienTheSanPham
      return products.map((json) => BienTheSanPham.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load products: $e');
  }
}
