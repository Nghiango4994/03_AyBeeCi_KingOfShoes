import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/views/ChiTietHoaDon_Screens.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class QuanLyDonHangScreen extends StatefulWidget {
  @override
  _QuanLyDonHangScreenState createState() => _QuanLyDonHangScreenState();
}

class _QuanLyDonHangScreenState extends State<QuanLyDonHangScreen> {
  String trangThaiDuocChon = "Tất cả";

  final List<String> trangThaiDonHang = [
    "Tất cả",
    "Chờ duyệt",
    "Đang chuẩn bị hàng",
    "Đang giao hàng",
    "Đã nhận hàng",
    "Đã hủy",
    "Đã trả",
    "Yêu cầu trả",
    "Đang chờ đơn vị vận chuyển",
    "Đã hoàn tất",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: trangThaiDuocChon,
              onChanged: (value) {
                setState(() {
                  trangThaiDuocChon = value!;
                });
              },
              items: trangThaiDonHang.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Giả định số lượng đơn hàng
              itemBuilder: (context, index) {
                // Dữ liệu mẫu cho đơn hàng
                final donHang = {
                  "orderCode": "DH${index + 1}",
                  "customerName": "Khách hàng ${index + 1}",
                  "orderDate": "15/01/2025",
                  "status": trangThaiDonHang[index % trangThaiDonHang.length],
                  "totalPrice": 100000 + (index * 50000),
                };

                // Lọc trạng thái
                if (trangThaiDuocChon != "Tất cả" &&
                    donHang['status'] != trangThaiDuocChon) {
                  return const SizedBox.shrink();
                }

                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mã đơn hàng: ${donHang['orderCode']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Khách hàng: ${donHang['customerName']}'),
                            const SizedBox(height: 8.0),
                            Text('Ngày đặt: ${donHang['orderDate']}'),
                            const SizedBox(height: 8.0),
                            Text('Trạng thái: ${donHang['status']}'),
                            const SizedBox(height: 8.0),
                            Text(
                              'Tổng tiền: ${numberFormat.format(donHang['totalPrice'])} VND',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 8.0),
                            CustomButton(
                                text: "Xem Chi Tiết",
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InvoiceDetailScreen()));
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
