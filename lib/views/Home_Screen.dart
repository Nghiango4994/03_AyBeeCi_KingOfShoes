import 'package:flutter/material.dart';
import 'package:kingofshoes/models/bien_the_san_pham.dart';
import 'package:kingofshoes/viewmodels/Home_ViewModel.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/views/Cart_Screen.dart';
import 'package:kingofshoes/views/CheckOutScreens.dart';
import 'package:kingofshoes/views/Detail_Screen.dart';
import 'package:kingofshoes/views/Favourite_Screen.dart';
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Địa chỉ",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      Text(
                        "TP.Hồ Chí Minh",
                        style: TextStyle(
                            color: ColorSelectorLightMode.MauChuNoiDung,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
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
            const UserAccountsDrawerHeader(
              accountName: Text('Alisson Becker'),
              accountEmail: Text('alisson@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://scontent.fsgn17-1.fna.fbcdn.net/v/t39.30808-6/293329717_1226220441540953_5971881406164118209_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeEpDmVK6NJFghZv3KtqypHhAsCoGtD0e2cCwKga0PR7Z69yWfRMO0sEWS-aIBHEthR_BqaoyJckSJ5oXPQAyW3y&_nc_ohc=JsPXlMcfuTwQ7kNvgG7o9dh&_nc_zt=23&_nc_ht=scontent.fsgn17-1.fna&_nc_gid=AnJ_Hrb7r0c4i_0GwGc3Dw8&oh=00_AYDmWa6655OGx-QMAxJGPBr1b4zjefYDPGwDKQQFFAdhvA&oe=6774744A'),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang Chủ'),
              onTap: () {
                Navigator.push(
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
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.list),
            //   title: const Text('Đặt Hàng'),
            //   onTap: () {},
            // ),
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
              leading: const Icon(Icons.logout),
              title: const Text('Đăng Xuất'),
              onTap: () async {
                await LoginService.clearUserData();
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
            final products = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: SizedBox(
                      width: 400,
                      child: CustomSearch(hintText: "Tìm kiếm"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  ScrollConfiguration(
                    behavior: Scroll(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: products.map((product) {
                          return InkWell(
                            onTap: () {
                              print(product.anhSp?.duong_dan_anh ?? '');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detail_Screen(id: "${product.id}")));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: 200,
                                child: CustomCardshoespopular(
                                  imageUrl: product.anhSp?.duong_dan_anh ?? '',
                                  name: product.ten_bien_the,
                                  price: product.gia_ban.toString(),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Mới Cập Nhật",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ScrollConfiguration(
                    behavior: Scroll(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: products.map((product) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: 200,
                                child: CustomCardshoespopular(
                                  imageUrl: product.anhSp?.duong_dan_anh ?? '',
                                  name: product.ten_bien_the,
                                  price: product.gia_ban.toString(),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
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
