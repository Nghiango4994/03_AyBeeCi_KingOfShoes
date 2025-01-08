import 'package:flutter/material.dart';

class CustomCardshoesarrivals extends StatefulWidget {
  final imageUrl;
  final name;
  final price;
  const CustomCardshoesarrivals({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  State<CustomCardshoesarrivals> createState() =>
      _CustomCardshoesarrivalsState();
}

class _CustomCardshoesarrivalsState extends State<CustomCardshoesarrivals> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
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
