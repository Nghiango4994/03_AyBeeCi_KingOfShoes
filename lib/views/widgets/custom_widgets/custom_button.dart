import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const CustomButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Đường viền bo tròn
        ),
        backgroundColor: ColorSelectorLightMode.MauNenButton,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Màu chữ
          fontSize: 18,
        ),
      ),
    );
  }
}
