import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kingofshoes/views/widgets/Provider.dart';

import '../models/hoa_don.dart';

class HoaDonViewModel extends ChangeNotifier {
  List<HoaDon> _hoaDonList = [];
  String _selectedStatus = "Tất cả";
  bool _isLoading = false;

  List<HoaDon> get hoaDonList => _selectedStatus == "Tất cả"
      ? _hoaDonList
      : _hoaDonList
          .where((hoaDon) =>
              mapTrangThaiToString(hoaDon.trangThaiVanChuyen) ==
              _selectedStatus)
          .toList();

  String get selectedStatus => _selectedStatus;
  bool get isLoading => _isLoading;

  void setSelectedStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }

  Future<void> fetchHoaDons({int? trangThaiVanChuyen}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Nếu trạng thái có giá trị, thêm vào URL
      final url = Uri.parse('${Providers.Url}/hoadon' +
          (trangThaiVanChuyen != null
              ? '?trangThaiVanChuyen=$trangThaiVanChuyen'
              : ''));

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          _hoaDonList = data.map((item) => HoaDon.fromJson(item)).toList();
          print('Danh sách hóa đơn: ${_hoaDonList.length} đơn hàng được tải.');
        } else {
          print('Lỗi từ API: ${jsonResponse['message']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String mapTrangThaiToString(int? status) {
    switch (status) {
      case 1:
        return "Chờ duyệt";
      case 2:
        return "Đang chuẩn bị hàng";
      case 3:
        return "Đang giao hàng";
      case 4:
        return "Đã nhận hàng";
      case 5:
        return "Đã hủy";
      case 6:
        return "Đã trả";
      case 7:
        return "Yêu cầu trả";
      case 8:
        return "Đang chờ đơn vị vận chuyển";
      case 9:
        return "Đã hoàn tất";
      default:
        return "Không xác định";
    }
  }
}
