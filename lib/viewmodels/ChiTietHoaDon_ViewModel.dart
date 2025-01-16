import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kingofshoes/models/chi_tiet_hoa_don.dart';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/views/widgets/Provider.dart';

class InvoiceDetailViewModel extends ChangeNotifier {
  List<ChiTietHoaDon> _chiTietHoaDons = [];
  List<ChiTietHoaDon> get chiTietHoaDons => _chiTietHoaDons;
  Future<void> fetchInvoiceDetails() async {
    final response = await http.get(Uri.parse('${Providers.Url}/chitietgiohang/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      _chiTietHoaDons =
          jsonResponse.map((data) => ChiTietHoaDon.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load invoice details');
    }
  }
}
