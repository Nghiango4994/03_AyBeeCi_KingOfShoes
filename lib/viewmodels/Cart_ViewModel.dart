import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/gio_hang.dart';
import 'package:kingofshoes/views/widgets/Provider.dart';

class CartViewModel extends ChangeNotifier {
  List<GioHang> _cartItems = [];
  bool _isLoading = false;

  List<GioHang> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  Future<void> fetchCartItems(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('${Providers.Url}/giohang/$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cartItems = (data['data'] as List)
            .map((item) => GioHang.fromJson(item))
            .toList();
      } else {
        print('Failed to load cart items. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load cart items');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> increaseQuantity(int idGioHang, int idBienThe) async {
    try {
      final response = await http.post(
        Uri.parse('${Providers.Url}/giohang/tang'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idGioHang': idGioHang, 'idBienThe': idBienThe}),
      );

      if (response.statusCode == 200) {
        await fetchCartItems(idGioHang.toString());
        notifyListeners(); // Thêm notifyListeners ở đây
      } else {
        print(
            'Failed to increase quantity. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to increase quantity');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to increase quantity');
    }
  }

  Future<void> decreaseQuantity(int idGioHang, int idBienThe) async {
    try {
      final response = await http.post(
        Uri.parse('${Providers.Url}/giohang/giam'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idGioHang': idGioHang, 'idBienThe': idBienThe}),
      );
      if (response.statusCode == 200) {
        await fetchCartItems(idGioHang.toString());
        notifyListeners(); // Thêm notifyListeners ở đây
      } else {
        print(
            'Failed to decrease quantity. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to decrease quantity');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to decrease quantity');
    }
  }

  // double calculateSubtotal() {
  //   return _cartItems.fold(0, (sum, item) => sum + ${item.} * item.soluong);
  // }

  // double calculateTotalCost() {
  //   const double shippingCost = 40.90;
  //   return calculateSubtotal() + shippingCost;
  // }
  Future<void> addProductToCart(
      int idBienThe, int id_khach_hang, String kich_thuoc) async {
    try {
      final response = await http.post(
        Uri.parse('${Providers.Url}/giohang'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          // Đảm bảo tên khóa đúng
          'id_bien_the_san_pham': idBienThe, // Đảm bảo tên khóa đúng
          'id_khach_hang': id_khach_hang, // Đảm bảo tên khóa đúng
          'so_luong': 1,
          'kich_thuoc': kich_thuoc,
        }),
      );
      print('id_bien_the: $idBienThe');
      print('id_khach_hang: $id_khach_hang');
      print(response.body);
      if (response.statusCode == 200) {
        fetchCartItems(id_khach_hang.toString());
      } else {
        print(
            'Failed to add product to cart. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception('Failed to add product to cart');
    }
  }
}
