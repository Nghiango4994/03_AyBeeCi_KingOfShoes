import 'package:flutter/material.dart';
import 'package:kingofshoes/models/bien_the_san_pham.dart';
import 'package:kingofshoes/viewmodels/Home_ViewModel.dart';
import 'package:kingofshoes/views/Favourite_Screen.dart';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Notification_Screen.dart';
import 'package:kingofshoes/views/ProfileScreen.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_CardShoesPopular.dart';

class SeeAll_Screen extends StatefulWidget {
  const SeeAll_Screen({super.key});

  @override
  State<SeeAll_Screen> createState() => _SeeAll_ScreenState();
}

class _SeeAll_ScreenState extends State<SeeAll_Screen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tất Cả Sản Phẩm',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<BienTheSanPham>>(
        future: fetchProducts(), // Lấy sản phẩm từ API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Hiển thị khi đang tải
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Lỗi: ${snapshot.error}')); // Hiển thị lỗi
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Không có sản phẩm nào.')); // Nếu không có sản phẩm
          } else {
            final products = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột trong lưới
                  crossAxisSpacing: 10.0, // Khoảng cách ngang giữa các item
                  mainAxisSpacing: 10.0, // Khoảng cách dọc giữa các item
                  childAspectRatio:
                      0.9, // Tỷ lệ chiều rộng/chiều cao của mỗi item
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      // Thực hiện hành động khi nhấn vào sản phẩm
                    },
                    child: CustomCardshoespopular(
                      imageUrl:
                          product.anhSp?.duong_dan_anh ?? '', // Ảnh sản phẩm
                      name: product.ten_bien_the, // Tên sản phẩm
                      price: product.gia_ban.toString(), // Giá sản phẩm
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        mini: true,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CartScreen(id: "1")));
          },
          icon: const Icon(
            Icons.shopping_bag,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                color: _selectedIndex == 0 ? Colors.blue : Colors.black,
                icon: const Icon(Icons.home),
                onPressed: () {
                  _onItemTapped(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Home_Screen()),
                  );
                }),
            IconButton(
              color: _selectedIndex == 1 ? Colors.blue : Colors.black,
              icon: const Icon(Icons.favorite),
              onPressed: () {
                _onItemTapped(1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouriteScreen()),
                );
              },
            ),
            const SizedBox(width: 48.0),
            IconButton(
              color: _selectedIndex == 2 ? Colors.blue : Colors.black,
              icon: const Icon(Icons.notifications),
              onPressed: () {
                _onItemTapped(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
            ),
            IconButton(
              color: _selectedIndex == 3 ? Colors.blue : Colors.black,
              icon: const Icon(Icons.person),
              onPressed: () {
                _onItemTapped(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
