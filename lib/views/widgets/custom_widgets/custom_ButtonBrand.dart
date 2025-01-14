import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonBrand extends StatefulWidget {
  final String brand;
  final String label;
  final ValueNotifier<int> selectedIndex;
  final int index;

  const CustomButtonBrand(
      {super.key,
      required this.label,
      required this.selectedIndex,
      required this.index,
      required this.brand});

  @override
  State<CustomButtonBrand> createState() => _CustomButtonBrandState();
}

class _CustomButtonBrandState extends State<CustomButtonBrand> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectedIndex.value = widget.index;
      },
      child: ValueListenableBuilder<int>(
        valueListenable: widget.selectedIndex,
        builder: (context, value, child) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: value == widget.index
                  ? Colors.blue
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      25.0), // Adjust the radius to match the image
                  child: SvgPicture.network(
                    widget.brand,
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: value == widget.index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
