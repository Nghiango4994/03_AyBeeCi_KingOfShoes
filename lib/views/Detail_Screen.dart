import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kingofshoes/models/bien_the_san_pham.dart';
import 'package:kingofshoes/models/kich_thuoc_san_pham.dart';
import 'package:kingofshoes/viewmodels/Cart_ViewModel.dart';
import 'package:kingofshoes/viewmodels/Detail_ViewModel.dart';
import 'package:kingofshoes/views/Cart_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail_Screen extends StatefulWidget {
  const Detail_Screen({super.key, required this.id});
  final String id;

  @override
  State<Detail_Screen> createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {
  late Future<BienTheSanPham?> futureProduct;
  late Future<List<KichThuocSanPham>> futureSizes;
  String? selectedSize;
  int? idKhachHang;
  TextEditingController quantityController = TextEditingController(text: '1');
  @override
  void initState() {
    super.initState();
    futureProduct = DetailViewModel().fetchProduct(widget.id);
    futureSizes = ProductSize().fetchSize();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    String? token = prefs.getString('token');

    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      print('User ID: ${user['id']}');
      print('User Name: ${user['ten']}');
      idKhachHang = user['id'] as int;
    }

    if (token != null) {
      print('Token: $token');
    }
  }

  @override
  void dispose() {
    quantityController.dispose(); // Giải phóng controller khi không còn sử dụng
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: FutureBuilder<BienTheSanPham?>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No product data found.'));
          } else {
            final product = snapshot.data!;
            final imageUrl = product.anhSp?.duong_dan_anh ?? '';

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Section
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Product Detail
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.ten_bien_the,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Mô tả sản phẩm: ${product.mo_ta}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Giá: \$${product.gia_ban}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Quantity Selector
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        int currentQuantity = int.tryParse(
                                                quantityController.text) ??
                                            1;
                                        if (currentQuantity > 1) {
                                          currentQuantity--;
                                          quantityController.text =
                                              currentQuantity.toString();
                                        }
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Số lượng',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        int currentQuantity = int.tryParse(
                                                quantityController.text) ??
                                            1;
                                        currentQuantity++;
                                        quantityController.text =
                                            currentQuantity.toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Size Selector
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FutureBuilder<List<KichThuocSanPham>>(
                            future: futureSizes,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text("Failed to load sizes.");
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text("No sizes available.");
                              } else {
                                final sizes = snapshot.data!;
                                return DropdownButtonFormField<String>(
                                  value: selectedSize,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSize = value;
                                    });
                                  },
                                  items: sizes.map((size) {
                                    return DropdownMenuItem(
                                      value: size.id.toString(),
                                      child: Text('Size ${size.tenKichThuoc}'),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    labelText: "Select Size",
                                    border: OutlineInputBorder(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        // Buttons Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Add to Cart Button
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      final int idSanPham = product.id;
                                      // ID sản phẩm thực tế
                                      final quantity = int.tryParse(
                                              quantityController.text) ??
                                          1;
                                      print(
                                          quantity); // Số lượng sản phẩm thực tế
                                      // Gọi phương thức thêm sản phẩm vào giỏ hàng
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartScreen()));
                                      await CartViewModel().addProductToCart(
                                        idSanPham,
                                        idKhachHang!,
                                        selectedSize!,
                                        quantity,
                                      ); // Truyền số lượng vào
                                      //Chuyển hướng sang trang giỏ hàng
                                    } catch (e) {
                                      print('Error adding product to cart: $e');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white, // Màu nền của nút
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Text(
                                    "Thêm vào giỏ hàng",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Xem giỏ hàng Button
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Chuyển hướng sang trang giỏ hàng
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => CartScreen(
                                    //       id: idKhachHang.toString(),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  child: const Text(
                                    "Mua ngay",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
