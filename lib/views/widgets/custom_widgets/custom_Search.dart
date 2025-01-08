import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';

class CustomSearch extends StatelessWidget {
  final String hintText;

  const CustomSearch({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
