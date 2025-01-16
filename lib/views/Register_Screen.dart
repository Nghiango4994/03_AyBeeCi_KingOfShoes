import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/color_selector.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_TextFormField.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_buttonSignInWith.dart';
import 'package:kingofshoes/viewmodels/RegisterService.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Register_Screen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      ),
      backgroundColor: ColorSelectorLightMode.MauNenUngDung,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: ColorSelectorLightMode.MauChuNoiDung,
                ),
              ),
              const Text(
                "Let's Create Account Together",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: CustomTextformfield(
                  controller: nameController,
                  labelText: "Your Name",
                  hintText: "Your Name",
                  suffixIcon: null,
                  isPassword: false,
                  isEditing: true,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: CustomTextformfield(
                  controller: emailController,
                  labelText: "Email Address",
                  hintText: "Email Address",
                  suffixIcon: null,
                  isPassword: false,
                  isEditing: true,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: CustomTextformfield(
                  controller: passwordController,
                  labelText: "Password",
                  hintText: "Password",
                  suffixIcon: const Icon(Icons.visibility_off,
                      color: ColorSelectorLightMode.MauChuNoiDung),
                  isPassword: true,
                  isEditing: true,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: CustomButton(
                  text: "Sign Up",
                  onClick: () {
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    RegisterService.register(name, email, password, context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: CustomButtonSignInWith(
                  text: "Sign in with Google",
                  onClick: () {},
                  IconSignIn:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png",
                ),
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have An Account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Sign In",
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
