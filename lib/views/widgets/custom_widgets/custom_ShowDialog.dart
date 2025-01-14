import 'package:flutter/material.dart';

class CustomShowdialog extends StatefulWidget {
  @override
  State<CustomShowdialog> createState() => _CustomShowdialogState();
}

class _CustomShowdialogState extends State<CustomShowdialog> {
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép đóng bằng cách chạm ra ngoài
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thành công!'),
          content: Text('Đăng ký/Đăng nhập thành công.'),
        );
      },
    );

    // Tự động đóng dialog sau 2 giây
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Đóng dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Đang đăng nhập...'),
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Text('Vui lòng chờ'),
        ],
      ),
    );
  }
}
