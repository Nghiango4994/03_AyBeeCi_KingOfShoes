import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/models/ChiTietHoaDon.dart';

class ProductViewModel extends ChangeNotifier {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/products';

  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        _products = data.map((item) => Product.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProduct(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to fetch product');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _products.add(product);
        notifyListeners();
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(int id, Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _products.indexWhere((p) => p.id == id);
        if (index != -1) {
          _products[index] = product;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$id'));
      if (response.statusCode == 200) {
        _products.removeWhere((p) => p.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class OrderViewModel extends ChangeNotifier {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/invoices';

  List<Order> orders = [];

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        orders = data.map((item) => Order.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Order> getOrder(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to fetch order');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createOrder(Order order) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        orders.add(order);
        notifyListeners();
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateOrder(int id, Order order) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 200) {
        final index = orders.indexWhere((o) => o.id == id);
        if (index != -1) {
          orders[index] = order;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update order');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$id'));
      if (response.statusCode == 200) {
        orders.removeWhere((o) => o.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete order');
      }
    } catch (e) {
      rethrow;
    }
  }
}
