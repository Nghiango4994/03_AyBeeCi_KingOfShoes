import 'package:flutter/material.dart';

class CustomButtonShoe extends StatefulWidget {
  final String src;
  final ValueNotifier<int> selectedIndex;
  final int index;

  const CustomButtonShoe({
    Key? key,
    required this.src,
    required this.selectedIndex,
    required this.index,
  }) : super(key: key);

  @override
  State<CustomButtonShoe> createState() => _CustomButtonShoeState();
}

class _CustomButtonShoeState extends State<CustomButtonShoe> {
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: value == widget.index ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipOval(
              child: Image.network(
                widget.src,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
