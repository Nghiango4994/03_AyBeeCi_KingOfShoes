import 'package:flutter/material.dart';
import 'package:kingofshoes/viewmodels/LoginService.dart';
import 'package:kingofshoes/views/Home_Screen.dart';
import 'package:kingofshoes/views/Register_Screen.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_TextFormField.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'widgets/custom_widgets/custom_buttonSignInWith.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _LoginState();
}

class _LoginState extends State<Login_Screen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hello Again!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: ColorSelectorLightMode.MauChuNoiDung,
                ),
              ),
              const Text(
                "Welcome Back You've Been Missed!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: CustomTextformfield(
                  controller: emailController,
                  labelText: "Email Address",
                  hintText: "Email Address",
                  suffixIcon: null,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: CustomTextformfield(
                  controller: passwordController,
                  labelText: "Password",
                  hintText: "Password",
                  suffixIcon: const Icon(Icons.visibility_off,
                      color: ColorSelectorLightMode.MauChuNoiDung),
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: CustomButton(
                    text: "Sign In",
                    onClick: () {
                      LoginService.login(emailController.text,
                          passwordController.text, context);
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: CustomButtonSignInWith(
                  text: "Sign in with google",
                  onClick: () {},
                  IconSignIn:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png",
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Have An Account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register_Screen(),
                          ));
                    },
                    child: const Text("Sign Up For Free",
                        style: TextStyle(
                            color: ColorSelectorLightMode.MauChuNoiDung,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
