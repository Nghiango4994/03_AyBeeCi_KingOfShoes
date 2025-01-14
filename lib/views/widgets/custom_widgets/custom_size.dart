import 'package:flutter/material.dart';

class CustomSize extends StatefulWidget {
  final String text;
  final ValueNotifier<int> selectedIndex;
  final int index;

  const CustomSize({
    Key? key,
    required this.text,
    required this.selectedIndex,
    required this.index,
  }) : super(key: key);

  @override
  State<CustomSize> createState() => _CustomSizeState();
}

class _CustomSizeState extends State<CustomSize> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectedIndex.value = widget.index;
      },
      child: ValueListenableBuilder<int>(
        valueListenable: widget.selectedIndex,
        builder: (context, value, child) {
          bool isSelected = value == widget.index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200), // Hiệu ứng mượt mà
            width: isSelected
                ? 70.0
                : 50.0, // Kích thước lớn hơn khi không được chọn
            height: isSelected ? 70.0 : 50.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize:
                      isSelected ? 20.0 : 16.0, // Tăng kích cỡ chữ phù hợp
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
