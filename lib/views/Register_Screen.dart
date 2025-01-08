import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomTextformfield(
              labelText: "Họ và Tên",
              hintText: "Nhập họ và tên",
              textEditingController: _nameController,
              suffixIcon: Icon(Icons.person),
            ),
            SizedBox(height: 20),
            CustomTextformfield(
              labelText: "Email",
              hintText: "Nhập email",
              textEditingController: _emailController,
              suffixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 20),
            CustomTextformfield(
              labelText: "Số điện thoại",
              hintText: "Nhập số điện thoại",
              textEditingController: _phoneController,
              suffixIcon: Icon(Icons.phone),
            ),
            SizedBox(height: 20),
            CustomTextformfield(
              labelText: "Địa chỉ",
              hintText: "Nhập địa chỉ",
              textEditingController: _addressController,
              suffixIcon: Icon(Icons.location_on),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextformfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;

  const CustomTextformfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.textEditingController,
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
                color: Colors.black,
              )),
          TextFormField(
            controller: textEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Vui lòng không để trống";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.blue, // set màu cho viền
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.blue, // set màu cho viền
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Colors.blue, // set màu cho viền
                  width: 2.0,
                ),
              ),
              filled: true,
              fillColor: Colors.blue[50], // set màu cho nền TextFormField
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
