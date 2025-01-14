import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_TextFormField.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class RecoveryPassword_Screen extends StatefulWidget {
  const RecoveryPassword_Screen({super.key});

  @override
  State<RecoveryPassword_Screen> createState() =>
      _RecoveryPassword_ScreenState();
}

class _RecoveryPassword_ScreenState extends State<RecoveryPassword_Screen> {
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
              'Recovery Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorSelectorLightMode.MauChuNoiDung,
                fontSize: 30,
              ),
            ),
            Text(
              'Please Enter Your Email Address To Recieve a Verification Code',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: CustomTextformfield(
                isPassword: false,
                labelText: "Email Address",
                hintText: "abc@example.com",
                suffixIcon: null,
                controller: null,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: CustomButton(text: "Continue", onClick: () {}),
            )
          ],
        ),
      ),
    );
  }
}
