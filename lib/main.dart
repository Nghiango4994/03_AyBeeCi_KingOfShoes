import 'package:flutter/material.dart';
import 'package:kingofshoes/views/CheckOutScreens.dart';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Login_Screen.dart';
import 'package:kingofshoes/views/ProfileScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home_Screen(),
    );
  }
}
