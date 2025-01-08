import 'package:flutter/material.dart';
//import 'package:kingofshoes/views/Login_Screen.dart';
//import 'package:kingofshoes/views/ProfileScreen.dart';
import 'package:kingofshoes/views/QuanLyDonHang.dart';
import 'package:kingofshoes/viewmodels/QuanLyHoaDon.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<OrderViewModel>(
      create: (_) => OrderViewModel(),
      builder: (context, child) {
        return QuanLyDonHangScreen();
      },
    );
  }
}
