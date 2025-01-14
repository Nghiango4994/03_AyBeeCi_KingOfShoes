import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_scroll.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_shoe.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_size.dart';

class Detail_Screen extends StatefulWidget {
  const Detail_Screen({super.key});

  @override
  State<Detail_Screen> createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {
  int _selectedIndexSize = 0;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    ValueNotifier<int> selectedIndex = ValueNotifier<int>(-1);
    ValueNotifier<int> selectedIndexSize = ValueNotifier<int>(-1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.shop))],
      ),
      backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.3,
              width: double.infinity,
              color: Colors.white,
              child: Image.network(
                "https://scontent.fsgn5-14.fna.fbcdn.net/v/t39.30808-6/455363345_1706115083299123_8063117899696330624_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=r89OOurQ0WwQ7kNvgHlGhap&_nc_zt=23&_nc_ht=scontent.fsgn5-14.fna&_nc_gid=AqooX7trwCgyhKE9ehcneGm&oh=00_AYB7by6cxBBEu684hNS22fg_g-7R2fGDWFvSPFX2s_OCGQ&oe=675D05D7",
              ),
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "BEST SELLER",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Nike Air Jodan",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        ColorSelectorLightMode.MauChuNoiDung),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "\$967.800",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Air Jodan is an American brand of basketball shoes athletic, casual, and style clothing produced by Nike...",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        ColorSelectorLightMode.MauChuNoiDung),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ScrollConfiguration(
                                  behavior: Scroll(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CustomButtonShoe(
                                          src:
                                              "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/20547d52-3e1b-4c3d-b917-f0d7e0eb8bdf/custom-nike-air-force-1-low-by-you-shoes.png",
                                          selectedIndex: selectedIndex,
                                          index: 0,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomButtonShoe(
                                          src:
                                              "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/20547d52-3e1b-4c3d-b917-f0d7e0eb8bdf/custom-nike-air-force-1-low-by-you-shoes.png",
                                          selectedIndex: selectedIndex,
                                          index: 1,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomButtonShoe(
                                          src:
                                              "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/20547d52-3e1b-4c3d-b917-f0d7e0eb8bdf/custom-nike-air-force-1-low-by-you-shoes.png",
                                          selectedIndex: selectedIndex,
                                          index: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomButtonShoe(
                                          src:
                                              "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/20547d52-3e1b-4c3d-b917-f0d7e0eb8bdf/custom-nike-air-force-1-low-by-you-shoes.png",
                                          selectedIndex: selectedIndex,
                                          index: 3,
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Size",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: ColorSelectorLightMode
                                            .MauChuNoiDung),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndexSize = 0;
                                          });
                                        },
                                        child: Text(
                                          "EU",
                                          style: TextStyle(
                                              fontWeight:
                                                  _selectedIndexSize == 0
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndexSize = 1;
                                          });
                                        },
                                        child: Text(
                                          "US",
                                          style: TextStyle(
                                              fontWeight:
                                                  _selectedIndexSize == 1
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndexSize = 2;
                                          });
                                        },
                                        child: Text(
                                          "UK",
                                          style: TextStyle(
                                              fontWeight:
                                                  _selectedIndexSize == 2
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ScrollConfiguration(
                                  behavior: Scroll(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CustomSize(
                                          text: "36",
                                          selectedIndex: selectedIndexSize,
                                          index: 0,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "37",
                                          selectedIndex: selectedIndexSize,
                                          index: 1,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "38",
                                          selectedIndex: selectedIndexSize,
                                          index: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "39",
                                          selectedIndex: selectedIndexSize,
                                          index: 3,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "40",
                                          selectedIndex: selectedIndexSize,
                                          index: 4,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "41",
                                          selectedIndex: selectedIndexSize,
                                          index: 5,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "42",
                                          selectedIndex: selectedIndexSize,
                                          index: 6,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        CustomSize(
                                          text: "43",
                                          selectedIndex: selectedIndexSize,
                                          index: 7,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),
            SizedBox(
                height: screenHeight * 0.1, // Chiều cao phần dưới
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$849.69",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorSelectorLightMode.MauChuNoiDung,
                                fontSize: 20),
                          )
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        onClick: () {},
                        text: "Add to Cart",
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
