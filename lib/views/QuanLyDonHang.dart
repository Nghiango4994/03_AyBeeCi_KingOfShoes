import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/viewmodels/QuanLyHoaDon.dart';
import 'package:kingofshoes/views/ChiTietHoaDon_Screens.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:provider/provider.dart';

class QuanLyDonHangScreen extends StatefulWidget {
  @override
  _QuanLyDonHangScreenState createState() => _QuanLyDonHangScreenState();
}

class _QuanLyDonHangScreenState extends State<QuanLyDonHangScreen> {
  String trangThaiDuocChon = "Tất cả"; // biến lưu trạng thái hiện tại

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
      Provider.of<HoaDonViewModel>(context, listen: false)
          .fetchHoaDons(); // tải ds
    });
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat =
        NumberFormat('#,##0'); // định dạng hàng ngàn thư viện intl

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 20),
        leading: IconButton(
            onPressed: () async {
              await LoginService.clearUserData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login_Screen()));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            )),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Consumer<HoaDonViewModel>(
          builder: (context, hoaDonViewModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Trạng thái:'),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButton<String>(
                          // dạng combobox lọc trạng thái
                          value: trangThaiDuocChon,
                          onChanged: (value) {
                            setState(() {
                              trangThaiDuocChon =
                                  value!; // vì value dạng string (nullable) nên phải ép
                              hoaDonViewModel
                                  .setSelectedStatus(trangThaiDuocChon);
                            });
                          },
                          items: trangThaiDonHang.map((status) {
                            // chuyển mỗi phần tử thành 1 item
                            return DropdownMenuItem<String>(
                              value: status, //
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(status), //
                              ),
                            );
                          }).toList(),
                          underline:
                              SizedBox(), //Xóa dòng gạch chân mặc định của Dropdown bằng
                          //cách thay thế nó bằng một SizedBox trống
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    //hỗ trợ tính năng kéo xuống để làm mới
                    onRefresh: () async {
                      // Gọi lại dữ liệu khi kéo xuống
                      await hoaDonViewModel.fetchHoaDons();
                    },
                    child: hoaDonViewModel.isLoading //
                        ? Center(child: CircularProgressIndicator()) //true
                        : ListView.builder(
                            //false
                            itemCount: hoaDonViewModel.hoaDonList.length,
                            itemBuilder: (context, index) {
                              final donHang = hoaDonViewModel.hoaDonList[index];

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    'Mã đơn hàng: DH${donHang.hoaDonId}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text(
                                          'Khách hàng: ${donHang.khachHangId}'),
                                      SizedBox(height: 8.0),
                                      Text(
                                          'Ngày đặt: ${DateFormat('dd/MM/yyyy').format(donHang.ngayLap)}'),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Trạng thái: ${hoaDonViewModel.mapTrangThaiToString(donHang.trangThaiVanChuyen)}',
                                        style: TextStyle(
                                          color:
                                              hoaDonViewModel.getTrangThaiColor(
                                                  donHang.trangThaiVanChuyen),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChiTietHoaDonScreen(),
                                        ),
                                      );
                                    },
                                  ),
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
      ),
    );
  }
}
