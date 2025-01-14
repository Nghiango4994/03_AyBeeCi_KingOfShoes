import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/bien_the_san_pham.dart';
import 'package:kingofshoes/models/kich_thuoc_san_pham.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class DetailViewModel {
  String url = Providers.Url; // Thay đổi IP nếu cần
  Future<BienTheSanPham?> fetchProduct(String id) async {
    try {
      final response =
          await http.get(Uri.parse('${Providers.Url}/bienthe/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BienTheSanPham.fromJson(data['data']);
      } else {
        throw Exception(
            'Failed to load product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }
}

class ProductSize {
  Future<List<KichThuocSanPham>> fetchSize() async {
    try {
      final response = await http.get(Uri.parse('${Providers.Url}/sizes'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final sizeList = (data['data'] as List<dynamic>)
            .map((item) => KichThuocSanPham.fromJson(item))
            .toList();
        return sizeList;
      } else {
        throw Exception(
            'Failed to load sizes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch sizes: ${e.toString()}');
    }
  }
}
