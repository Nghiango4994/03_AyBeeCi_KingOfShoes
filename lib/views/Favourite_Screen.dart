import 'package:flutter/material.dart';

import 'package:kingofshoes/views/widgets/custom_widgets/custom_CardFavourite.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Favourite",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.favorite_border_sharp),
              )),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {
              // Home_Screen()._onItemTapped(1);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Số cột
        crossAxisSpacing: 10, // Khoảng cách ngang giữa các item
        mainAxisSpacing: 10, // Khoảng cách dọc giữa các item
        children: List.generate(6, (index) {
          return Container(
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(0.6),
                child: SingleChildScrollView(
                  child: CustomCardfavourite(
                    imageUrl:
                        "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/067ea325-267a-4c9c-8148-d62eeee1e329/W+AIR+FORCE+1+%2707+NEXT+NATURE.png",
                    name: "abc",
                    price: "5645646",
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
