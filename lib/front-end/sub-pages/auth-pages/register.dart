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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //===============Declare Variable=======================================//
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailValidate = false;
  bool passwordValidate = false;
  bool isEmailCorrect = false;
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
    emailController.clear();
    passwordController.clear();
    toaster(
        message: "Account created successfully..!",
        backColor: Colors.greenAccent);
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
            circleAvatarWidget(imageUrl: "assets/images/cr7.png"),

            //==========================Text Login====================================//
            textWidget(title: "SIGN UP"),
            
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
                      labelText: 'email',
                      textController: emailController,
                      isHide: false,
                      onChanged: (val) {
                        setState(() {
                          emailValidate = isEmail(val);
                        });
                      },
                      textInputType: TextInputType.text,
                      iconSuffix: emailValidate == false
                          ? Icons.close_sharp
                          : Icons.done),
                  //==========================Text Field Password================================//
                  textFieldWidget(
                    iconPrefix: Icons.vpn_key,
                    autoFocus: false,
                    onChanged: (val) {
                      setState(() {
                        passwordValidate = isLength(val, 6, 32);
                      });
                    },
                    labelText: 'password',
                    textController: passwordController,
                    isHide: true,
                    textInputType: TextInputType.text,
                    iconSuffix: passwordValidate == false
                        ? Icons.close_sharp
                        : Icons.done,
                    focus: focus,
                  ),

                  //==========================Button Login==================================//
                  animationButtonWidget(
                    iconButton: Icons.app_registration_outlined,
                    label: 'Sign Up',
                    buttonColor: Colors.blueAccent,
                    onClick: () {
                      final response = getValidate();
                      if (response == false) {
                        response;
                      } else {
                        createAccount();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have account got to:"),
                      const SizedBox(width: 5),
                      textButtonWidget(
                          onClick: () =>
                              Navigator.pushReplacementNamed(context, "/login"),
                          text: "Sign In"),
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

  //========================Function Sign Up=====================================//
  Future<void> createAccount() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .whenComplete(() {
        // auth.app;
        clearText();
      });
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
