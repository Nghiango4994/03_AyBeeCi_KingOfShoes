import 'package:flutter/material.dart';
import 'package:kingofshoes/models/gio_hang.dart';
import 'package:kingofshoes/viewmodels/Cart_ViewModel.dart';
import 'package:provider/provider.dart';
import 'package:kingofshoes/views/CheckOutScreens.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  final String id;
  const CartScreen({super.key, required this.id});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewModel()..fetchCartItems(widget.id),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Giỏ Hàng')),
          backgroundColor: ColorSelectorLightMode.MauNenUngDung,
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
        body: Consumer<CartViewModel>(
          builder: (context, viewModel, child) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.fetchCartItems(widget.id);
                await Future.delayed(
                    const Duration(seconds: 2)); // Trì hoãn 2 giây
              },
              color: Colors.blue,
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.cartItems.isEmpty
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
                          itemCount: viewModel.cartItems.length,
                          itemBuilder: (context, index) {
                            return _buildCartItem(viewModel.cartItems[index],
                                viewModel, widget.id);
                          },
                        ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartItem(GioHang item, CartViewModel viewModel, String id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: item.bienTheSanPham.map((bienThe) {
          return Card(
            // Thêm Card để tạo viền cho sản phẩm
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(bienThe.anhSp?.duong_dan_anh ?? '',
                      width: 80.0),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bienThe.ten_bien_the),
                        const SizedBox(height: 4.0),
                        Text('${bienThe.gia_ban.toString()} VNĐ'),
                        const SizedBox(height: 4.0),
                        Text('Size: ${bienThe.kich_thuoc_id}'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() async {
                            await viewModel.decreaseQuantity(
                                item.idGioHang, bienThe.id);
                            viewModel.fetchCartItems(id);
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text('${item.soluong}'),
                      IconButton(
                        onPressed: () {
                          setState(() async {
                            await viewModel.increaseQuantity(
                                item.idGioHang, bienThe.id);
                            viewModel.fetchCartItems(id);
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () {
                          // Xử lý xóa sản phẩm
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, viewModel, child) {
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
                    const Text('Subtotal: '),
                    // Text(
                    //     "${viewModel.calculateSubtotal()} VNĐ"), // Hiển thị subtotal
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('Shipping: '), Text("40.90 VNĐ")],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Cost: '),
                    // Text(
                    //     "${viewModel.calculateTotalCost()} VNĐ",
                    //     ), // Hiển thị tổng chi phí
                  ],
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    text: "Checkout",
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
}
