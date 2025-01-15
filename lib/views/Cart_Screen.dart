import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/models/gio_hang.dart';
import 'package:kingofshoes/viewmodels/Cart_ViewModel.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:provider/provider.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? idKhachHang;
  List<bool> _selectedValues = []; // Danh sách trạng thái của các sản phẩm
  double _selectedTotal = 0.0; // Tổng giá trị các sản phẩm được chọn

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await LoginService.getUserData();
    if (userData != null) {
      setState(() {
        idKhachHang = userData['id'].toString();
        print(idKhachHang);
      });
    } else {
      // Hiển thị dialog thông báo
      _showLoginDialog();
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Bạn cần đăng nhập để sử dụng chức năng này.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Đăng nhập'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login_Screen()),
                );
              },
            ),
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (idKhachHang == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Giỏ Hàng')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return ChangeNotifierProvider(
      create: (_) => CartViewModel()..fetchCartItems(idKhachHang!),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Giỏ Hàng')),
          backgroundColor: ColorSelectorLightMode.MauNenUngDung,
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
        body: Consumer<CartViewModel>(
          builder: (context, viewModel, child) {
            List reversedCartItems =
                viewModel.cartItems?.reversed?.toList() ?? [];

            // Khởi tạo trạng thái nếu danh sách thay đổi
            if (_selectedValues.length != reversedCartItems.length) {
              _selectedValues =
                  List<bool>.filled(reversedCartItems.length, false);
            }

            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.fetchCartItems(idKhachHang!);
              },
              color: Colors.blue,
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : reversedCartItems.isEmpty
                      ? ListView(
                          children: const [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child:
                                    Text('Không có sản phẩm trong giỏ hàng.'),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: reversedCartItems.length,
                          itemBuilder: (context, index) {
                            return _buildCartItem(reversedCartItems[index],
                                viewModel, idKhachHang!, index);
                          },
                        ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartItem(
      GioHang item, CartViewModel viewModel, String id, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              value: _selectedValues[index],
              onChanged: (bool? value) {
                setState(() {
                  _selectedValues[index] = value!;
                  _calculateSelectedTotal(viewModel.cartItems ?? []);
                });
              },
            ),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.bienTheSanPham.first.anhSp?.duong_dan_anh ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.bienTheSanPham.first.ten_bien_the),
                  const SizedBox(height: 4.0),
                  Text("Kích cỡ: ${item.kich_thuoc}"),
                  const SizedBox(height: 4.0),
                  Text(
                      '${formatCurrency(item.bienTheSanPham.first.gia_ban)} VNĐ'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await viewModel.decreaseQuantity(
                        item.idGioHang, item.id_bien_the);
                    viewModel.fetchCartItems(id);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text('${item.soluong}'),
                IconButton(
                  onPressed: () async {
                    await viewModel.increaseQuantity(
                        item.idGioHang, item.id_bien_the);
                    viewModel.fetchCartItems(id);
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () async {
                    await viewModel.deleteItem(item.idGioHang);
                    viewModel.fetchCartItems(id);
                  },
                  icon: const Icon(Icons.delete, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: BottomAppBar(
        color: Colors.white,
        elevation: 8.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Tổng cộng:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('${formatCurrency(_selectedTotal)} VNĐ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                text: "Thanh toán",
                onClick: () {
                  // Xử lý sự kiện thanh toán
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateSelectedTotal(List<GioHang> cartItems) {
    _selectedTotal = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      if (_selectedValues[i]) {
        _selectedTotal +=
            cartItems[i].bienTheSanPham.first.gia_ban * cartItems[i].soluong;
      }
    }
  }

  String formatCurrency(double value) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return formatter.format(value);
  }
}
