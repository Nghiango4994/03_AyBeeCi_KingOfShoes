import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/viewmodels/QuanLyHoaDon.dart';
import 'package:kingofshoes/views/ChiTietHoaDon_Screens.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:provider/provider.dart';

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
    // Fetch orders when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HoaDonViewModel>(context, listen: false).fetchHoaDons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
      ),
      body: Consumer<HoaDonViewModel>(
        // Chỉnh sửa để hiển thị đúng dữ liệu
        builder: (context, hoaDonViewModel, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  value: trangThaiDuocChon,
                  onChanged: (value) {
                    setState(() {
                      trangThaiDuocChon = value!;
                      hoaDonViewModel.setSelectedStatus(trangThaiDuocChon);
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Gọi lại dữ liệu khi kéo xuống
                    await hoaDonViewModel.fetchHoaDons();
                  },
                  child: hoaDonViewModel.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: hoaDonViewModel.hoaDonList.length,
                          itemBuilder: (context, index) {
                            final donHang = hoaDonViewModel.hoaDonList[index];

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mã đơn hàng: DH${donHang.hoaDonId}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                            'Khách hàng: ${donHang.khachHangId}'),
                                        const SizedBox(height: 8.0),
                                        Text(
                                            'Ngày đặt: ${DateFormat('dd/MM/yyyy').format(donHang.ngayLap)}'),
                                        const SizedBox(height: 8.0),
                                        Text(
                                            'Trạng thái: ${hoaDonViewModel.mapTrangThaiToString(donHang.trangThaiVanChuyen)}'),
                                        const SizedBox(height: 8.0),
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
                                        CustomButton(
                                          text: "Xem Chi Tiết",
                                          onClick: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InvoiceDetailScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
