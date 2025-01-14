import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';

class CustomTextformfield extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool isPassword; // Thêm thuộc tính này để xác định ô nhập mật khẩu
  const CustomTextformfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.controller,
    required this.isPassword, // Mặc định là false
  });

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText,
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
            obscureText: widget.isPassword ? _isObscured : false,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
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
              suffixIcon: widget
                      .isPassword // Chỉ hiển thị nút ẩn/hiện mật khẩu nếu là ô mật khẩu
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
