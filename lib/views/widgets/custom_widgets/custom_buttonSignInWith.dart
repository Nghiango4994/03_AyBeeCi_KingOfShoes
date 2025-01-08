import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';

class CustomButtonSignInWith extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final String IconSignIn;

  const CustomButtonSignInWith(
      {super.key,
      required this.text,
      required this.onClick,
      required this.IconSignIn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Đường viền bo tròn
        ),
        backgroundColor:
            ColorSelectorLightMode.MauNenButtonSignInWith, // màu nền button
      ),
      child: Row(
        children: [
          Image.network(
            IconSignIn, width: 24, // Kích thước ảnh
            height: 24,
          ),
          Text(
            text,
            style: const TextStyle(
              color: ColorSelectorLightMode.MauChuNoiDung, // Màu chữ
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
