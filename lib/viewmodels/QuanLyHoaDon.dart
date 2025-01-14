// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:kingofshoes/models/san_pham.dart';

// class SanPhamViewModel extends ChangeNotifier {
//   static const String _baseUrl = 'http://127.0.0.1:8000/api/SanPhams';

//   List<SanPham> _SanPhams = [];
//   List<SanPham> get SanPhams => _SanPhams;

//   Future<void> fetchSanPhams() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as List<dynamic>;
//         _SanPhams = data.map((item) => SanPham.fromJson(item)).toList();
//         notifyListeners();
//       } else {
//         throw Exception('Failed to fetch SanPhams');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<SanPham> getSanPham(int id) async {
//     try {
//       final response = await http.get(Uri.parse('$_baseUrl/$id'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return SanPham.fromJson(data);
//       } else {
//         throw Exception('Failed to fetch SanPham');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> createSanPham(SanPham SanPham) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(SanPham.toJson()),
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         _SanPhams.add(SanPham);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to create SanPham');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> updateSanPham(int id, SanPham SanPham) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$_baseUrl/$id'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(SanPham.toJson()),
//       );
//       if (response.statusCode == 200) {
//         final index = _SanPhams.indexWhere((p) => p.id == id);
//         if (index != -1) {
//           _SanPhams[index] = SanPham;
//           notifyListeners();
//         }
//       } else {
//         throw Exception('Failed to update SanPham');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> deleteSanPham(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$_baseUrl/$id'));
//       if (response.statusCode == 200) {
//         _SanPhams.removeWhere((p) => p.id == id);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to delete SanPham');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// class OrderViewModel extends ChangeNotifier {
//   static const String _baseUrl = 'http://127.0.0.1:8000/api/invoices';

//   List<Order> orders = [];

//   Future<void> fetchOrders() async {
//     try {
//       final response = await http.get(Uri.parse('$_baseUrl'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as List<dynamic>;
//         orders = data.map((item) => Order.fromJson(item)).toList();
//         notifyListeners();
//       } else {
//         throw Exception('Failed to fetch orders');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Order> getOrder(int id) async {
//     try {
//       final response = await http.get(Uri.parse('$_baseUrl/$id'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return Order.fromJson(data);
//       } else {
//         throw Exception('Failed to fetch order');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> createOrder(Order order) async {
//     try {
//       final response = await http.post(
//         Uri.parse(_baseUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(order.toJson()),
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         orders.add(order);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to create order');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> updateOrder(int id, Order order) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$_baseUrl/$id'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(order.toJson()),
//       );
//       if (response.statusCode == 200) {
//         final index = orders.indexWhere((o) => o.id == id);
//         if (index != -1) {
//           orders[index] = order;
//           notifyListeners();
//         }
//       } else {
//         throw Exception('Failed to update order');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> deleteOrder(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$_baseUrl/$id'));
//       if (response.statusCode == 200) {
//         orders.removeWhere((o) => o.id == id);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to delete order');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
