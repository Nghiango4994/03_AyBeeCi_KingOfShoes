import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
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

class HomeViewModel {
  final ValueNotifier<List<BienTheSanPham>> filteredProductsNotifier =
      ValueNotifier<List<BienTheSanPham>>([]);
  List<BienTheSanPham> _allProducts = [];
  String? email;
  String? ten;
  String? anh;

  // Hàm để tải dữ liệu người dùng
  Future<void> loadUserData() async {
    final userData = await LoginService.getUserData();
    if (userData != null) {
      email = userData['email'].toString();
      ten = userData['ten'].toString();
      anh = userData['anh_user'].toString();
      print("email là : $email");
    } else {
      // Hiển thị dialog thông báo
    }
  }

  // Hàm để lọc sản phẩm
  void filterProducts(String query) {
    final filteredProducts = _allProducts
        .where((product) =>
            product.ten_bien_the.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filteredProductsNotifier.value =
        filteredProducts; // Cập nhật giá trị của ValueNotifier
  }

  // Hàm để cập nhật danh sách sản phẩm
  void updateProducts(List<BienTheSanPham> products) {
    _allProducts = products;
    filteredProductsNotifier.value =
        _allProducts; // Khởi tạo danh sách sản phẩm đã lọc
  }
}
