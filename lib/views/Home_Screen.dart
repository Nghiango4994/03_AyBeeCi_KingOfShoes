import 'package:flutter/material.dart';
import 'package:kingofshoes/models/bien_the_san_pham.dart';
import 'package:kingofshoes/viewmodels/Home_ViewModel.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/views/Cart_Screen.dart';
import 'package:kingofshoes/views/CheckOutScreens.dart';
import 'package:kingofshoes/views/Detail_Screen.dart';
import 'package:kingofshoes/views/Favourite_Screen.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/Notification_Screen.dart';
import 'package:kingofshoes/views/ProfileScreen.dart';
import 'package:kingofshoes/views/SeeAll_Screen.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_ButtonBrand.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_CardShoesPopular.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_Search.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_scroll.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_Screen> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(-1);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  String? email;
  String? ten;
  String? anh;

  List<BienTheSanPham> _allProducts = [];
  final ValueNotifier<List<BienTheSanPham>> filteredProductsNotifier =
      ValueNotifier<List<BienTheSanPham>>([]);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _loadUserData() async {
    final userData = await LoginService.getUserData();
    if (userData != null) {
      setState(() {
        email = userData['email'].toString();
        ten = userData['ten'].toString();
        anh = userData['anh_user'].toString();
        print("email là : $email");
      });
    } else {
      // Hiển thị dialog thông báo
    }
  }

  void _filterProducts(String query) {
    final filteredProducts = _allProducts
        .where((product) =>
            product.ten_bien_the.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filteredProductsNotifier.value =
        filteredProducts; // Cập nhật giá trị của ValueNotifier
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Trang Chủ",
          style: TextStyle(
              color: ColorSelectorLightMode.MauChuNoiDung,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
              _loadUserData();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: const Icon(Icons.shopping_bag, color: Colors.black)),
          )
        ],
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('${ten ?? ''}'),
              accountEmail: Text('${email ?? ''}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${anh ?? 'https://w7.pngwing.com/pngs/527/663/png-transparent-logo-person-user-person-icon-rectangle-photography-computer-wallpaper.png'}'),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang Chủ'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Home_Screen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Giỏ Hàng'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Yêu Thích'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavouriteScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Thông Báo'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(ten == null ? Icons.login : Icons.logout),
              title: Text(ten == null ? 'Đăng Nhập' : 'Đăng Xuất'),
              onTap: () async {
                if (ten != null) {
                  await LoginService.clearUserData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Home_Screen()));
                } else {
                  await LoginService.clearUserData();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login_Screen()));
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      body: FutureBuilder<List<BienTheSanPham>>(
        future: fetchProducts(), // Fetch products
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            _allProducts = snapshot.data!; // Lưu danh sách sản phẩm gốc
            filteredProductsNotifier.value =
                _allProducts; // Khởi tạo danh sách sản phẩm đã lọc

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearch(
                    hintText: "Tìm kiếm sản phẩm",
                    controller: _searchController,
                    onChanged: _filterProducts, // Sử dụng hàm lọc
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ScrollConfiguration(
                      behavior: Scroll(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CustomButtonBrand(
                              link: 'nike',
                              label: "Nike",
                              selectedIndex: selectedIndex,
                              index: 0,
                            ),
                            const SizedBox(width: 10),
                            CustomButtonBrand(
                              link: 'puma',
                              label: "Puma",
                              selectedIndex: selectedIndex,
                              index: 1,
                            ),
                            const SizedBox(width: 10),
                            CustomButtonBrand(
                              link: 'under_armour',
                              label: "Under Armour",
                              selectedIndex: selectedIndex,
                              index: 2,
                            ),
                            const SizedBox(width: 10),
                            CustomButtonBrand(
                              link: 'adidas',
                              label: "Adidas",
                              selectedIndex: selectedIndex,
                              index: 3,
                            ),
                            const SizedBox(width: 10),
                            CustomButtonBrand(
                              link: 'jordan',
                              label: "Jordan",
                              selectedIndex: selectedIndex,
                              index: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Text("Phổ Biến",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SeeAll_Screen()));
                          },
                          child: const Text("Xem tất cả",
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<List<BienTheSanPham>>(
                    valueListenable: filteredProductsNotifier,
                    builder: (context, filteredProducts, child) {
                      return ScrollConfiguration(
                        behavior: Scroll(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: filteredProducts.map((product) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail_Screen(
                                              id: "${product.id}")));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    width: 200,
                                    child: CustomCardshoespopular(
                                      imageUrl:
                                          product.anhSp?.duong_dan_anh ?? '',
                                      name: product.ten_bien_the,
                                      price: product.gia_ban.toString(),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Mới Cập Nhật",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Phần này có thể tương tự như phần "Phổ Biến" nếu cần
                  ValueListenableBuilder<List<BienTheSanPham>>(
                    valueListenable: filteredProductsNotifier,
                    builder: (context, filteredProducts, child) {
                      return ScrollConfiguration(
                        behavior: Scroll(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: filteredProducts.map((product) {
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SizedBox(
                                    width: 200,
                                    child: CustomCardshoespopular(
                                      imageUrl:
                                          product.anhSp?.duong_dan_anh ?? '',
                                      name: product.ten_bien_the,
                                      price: product.gia_ban.toString(),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
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
              onPressed: () => _onItemTapped(0),
            ),
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
