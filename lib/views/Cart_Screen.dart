import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/models/gio_hang.dart';
import 'package:kingofshoes/viewmodels/Cart_ViewModel.dart';
import 'package:provider/provider.dart';
import 'package:kingofshoes/views/CheckOutScreens.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? idKhachHang;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      idKhachHang = user['id'].toString();
    }
    setState(() {});
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
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.fetchCartItems(idKhachHang!);
                await Future.delayed(const Duration(seconds: 2));
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
                                viewModel, idKhachHang!);
                          },
                        ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartItem(GioHang item, CartViewModel viewModel, String id) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              item.bienTheSanPham.first.anhSp?.duong_dan_anh ?? '',
              width: 80.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.bienTheSanPham.first.ten_bien_the),
                  const SizedBox(height: 4.0),
                  Text(
                      '${formatCurrency(item.bienTheSanPham.first.gia_ban)} VNĐ'),
                  const SizedBox(height: 4.0),
                  Text('Số lượng: ${item.soluong}'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await viewModel.decreaseQuantity(
                        item.idGioHang, item.id_bien_the);
                    await viewModel.fetchCartItems(id);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text('${item.soluong}'),
                IconButton(
                  onPressed: () async {
                    await viewModel.increaseQuantity(
                        item.idGioHang, item.id_bien_the);
                    await viewModel.fetchCartItems(id);
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    // Logic xóa sản phẩm
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
    return Consumer<CartViewModel>(
      builder: (context, viewModel, child) {
        double totalCost = calculateTotal(viewModel.cartItems ?? []);
        String formattedTotalCost = formatCurrency(totalCost);
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('$formattedTotalCost VNĐ',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double calculateTotal(List<GioHang> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      for (var bienThe in item.bienTheSanPham) {
        total += bienThe.gia_ban.toDouble() * item.soluong;
      }
    }
    return total;
  }

  String formatCurrency(double value) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return formatter.format(value);
  }
}
