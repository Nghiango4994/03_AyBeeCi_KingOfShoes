import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kingofshoes/viewmodels/ChangePasswordViewmodel.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_TextFormField.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecoveryPassword_Screen extends StatefulWidget {
  const RecoveryPassword_Screen({super.key});

  @override
  State<RecoveryPassword_Screen> createState() =>
      _RecoveryPassword_ScreenState();
}

class _RecoveryPassword_ScreenState extends State<RecoveryPassword_Screen> {
  late Future<void> changePassword;
  int? idKhachHang;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    String? token = prefs.getString('token');

    if (userJson != null) {
      Map<String, dynamic> user = jsonDecode(userJson);
      idKhachHang = user['id'] as int;
    }

    if (token != null) {
      print('Token: $token');
    }
  }

  Future<void> handleChangePassword() async {
    if (newPasswordController.text == confirmPasswordController.text) {
      try {
        await ChangePasswordViewmodel().changePassword((idKhachHang.toString()),
            oldPasswordController.text, newPasswordController.text);

        // Hiển thị dialog thông báo thành công
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Thành công'),
            content: Text('Đổi mật khẩu thành công'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login_Screen()),
                    (route) => false,
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        //Hiển thị khi mật khẩu cũ không đúng
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Lỗi'),
            content: Text('Mật khẩu cũ không đúng'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        // Hiển thị dialog thông báo lỗi
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Lỗi'),
            content: Text('Đổi mật khẩu thất bại: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Hiển thị dialog thông báo mật khẩu không khớp
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Lỗi'),
          content: Text('Mật khẩu mới không khớp'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      ),
      backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Đổi mật khẩu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorSelectorLightMode.MauChuNoiDung,
                fontSize: 30,
              ),
            ),
            Text(
              'Nhập mật khẩu cũ của bạn',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: CustomTextformfield(
                isPassword: true,
                labelText: "Mật khẩu cũ",
                hintText: "Mật khẩu cũ",
                controller: oldPasswordController,
                suffixIcon: null,
                isEditing: true,
              ),
            ),
            Container(
              width: 300,
              child: CustomTextformfield(
                isPassword: true,
                labelText: "Mật khẩu mới",
                hintText: "Mật khẩu mới",
                controller: newPasswordController,
                suffixIcon: null,
                isEditing: true,
              ),
            ),
            Container(
              width: 300,
              child: CustomTextformfield(
                isPassword: true,
                labelText: "Nhập lại mật khẩu",
                hintText: "Nhập lại mật khẩu",
                controller: confirmPasswordController,
                suffixIcon: null,
                isEditing: true,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: CustomButton(
                text: "Thay đổi mật khẩu",
                onClick: handleChangePassword,
              ),
            )
          ],
        ),
      ),
    );
  }
}
