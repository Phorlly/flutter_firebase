import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:flutter_laravel/front-end/widgets/animattion_button.dart';
import 'package:flutter_laravel/front-end/widgets/circle_avatar.dart';
import 'package:flutter_laravel/front-end/widgets/text.dart';
import 'package:flutter_laravel/front-end/widgets/text_button.dart';
import 'package:flutter_laravel/front-end/widgets/text_field.dart';
import 'package:flutter_laravel/main.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //===============Declare Variable=======================================//
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailValidate = false;
  bool passwordValidate = false;
  final focus = FocusNode();

  //=================Dispose=============================//
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    focus.dispose();
    super.dispose();
  }

  dynamic clearText() {
    // emailController.clear();
    passwordController.clear();
    emailValidate = false;
    passwordValidate = false;
  }

  @override
  Widget build(BuildContext context) {
    // double widthButton=MediaQuery.of(context).size.width;
    double heightConent = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //==========================CircleAvatar==================================//
            circleAvatarWidget(imageUrl: "assets/images/flutter.png"),

            //==========================Text Login====================================//
            textWidget(title: "SIGN IN"),

            Container(
              height: heightConent,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  //==========================Text Field Email==================================//
                  textFieldWidget(
                      iconPrefix: Icons.email,
                      autoFocus: true,
                      onChanged: (val) {
                        setState(() {
                          emailValidate = isEmail(val);
                        });
                      },
                      labelText: 'email',
                      isValid: emailValidate,
                      textController: emailController,
                      isHide: false,
                      textInputType: TextInputType.text,
                      iconSuffix: emailValidate == false
                          ? Icons.close_sharp
                          : Icons.done),
                  //==========================Text Field Password================================//
                  textFieldWidget(
                    iconPrefix: Icons.vpn_key,
                    onChanged: (val) {
                      setState(() {
                        passwordValidate = isLength(val, 6, 32);
                      });
                    },
                    autoFocus: false,
                    labelText: 'password',
                    isValid: passwordValidate,
                    iconSuffix: passwordValidate == false
                        ? Icons.close_sharp
                        : Icons.done,
                    textController: passwordController,
                    isHide: true,
                    textInputType: TextInputType.text,
                    focus: focus,
                  ),
                  //==========================Button Forgot Password=========================//
                  textButtonWidget(
                      onClick: () =>
                          Navigator.pushNamed(context, "/reset-password"),
                      text: "Forgot password?"),
                  //==========================Button Login==================================//
                  animationButtonWidget(
                    iconButton: Icons.login,
                    buttonColor: Colors.blueAccent,
                    label: 'Sign In',
                    onClick: () {
                      bool response = getValidate();
                      if (response == false) {
                        response;
                      } else {
                        log(emailController.text);
                        log(passwordController.text);
                        signIn();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have account or not?"),
                      const SizedBox(width: 5),
                      textButtonWidget(
                          onClick: () => Navigator.pushReplacementNamed(
                              context, "/register"),
                          text: "Sign Up"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//========================Function Sign In=====================================//
  Future<void> signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await auth
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .whenComplete(() => clearText());
    } on FirebaseAuthException catch (err) {
      Utils.showSnackBar(err.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  //========================Function Validate=====================================//
  bool getValidate() {
    var isValid = true;
    if (emailController.text.isEmpty) {
      emailValidate = true;
      toaster(message: "Email cannot null..!", backColor: Colors.red);
      isValid = false;
    } else {
      emailValidate = false;
      if (passwordController.text.isEmpty) {
        passwordValidate = true;
        toaster(message: "Password cannot null..!", backColor: Colors.red);
        focus.requestFocus();
        isValid = false;
      } else {
        passwordValidate = false;
      }
    }

    return isValid;
  }
}
