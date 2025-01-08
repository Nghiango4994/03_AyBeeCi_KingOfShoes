import 'package:flutter/material.dart';

class CustomCardfavourite extends StatefulWidget {
  final imageUrl;
  final name;
  final price;
  const CustomCardfavourite({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });
  @override
  State<CustomCardfavourite> createState() => _FavouriteProductsPageState();
}

class _FavouriteProductsPageState extends State<CustomCardfavourite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: [
                      Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 5,
                        left: 3,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border_sharp),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "BEST SELLER",
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      '\$${widget.price}',
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Positioned(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.circle,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
