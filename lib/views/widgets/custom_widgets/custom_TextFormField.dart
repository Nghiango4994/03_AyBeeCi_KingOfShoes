import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';

class CustomTextformfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Widget? suffixIcon;

  const CustomTextformfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,
              style: const TextStyle(
                fontSize: 20,
                color: ColorSelectorLightMode.MauChuNoiDung,
              )),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng không để trống";
              }
              return null;
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  const TextStyle(color: ColorSelectorLightMode.MauChuNoiDung),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: ColorSelectorLightMode
                      .MauNenTextFormField, //set mau cho viền
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: ColorSelectorLightMode
                      .MauNenTextFormField, //set mau cho viền
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: ColorSelectorLightMode
                      .MauNenTextFormField, //set mau cho viền
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: ColorSelectorLightMode
                  .MauNenTextFormField, // set màu cho nền TextFormField
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
