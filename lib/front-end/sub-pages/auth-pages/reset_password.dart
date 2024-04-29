import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:flutter_laravel/front-end/widgets/animattion_button.dart';
import 'package:flutter_laravel/front-end/widgets/text_field.dart';
import 'package:flutter_laravel/main.dart';
import 'package:validators/validators.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  //===============Declare Variable=======================================//
  final emailController = TextEditingController();
  bool emailValidate = false;

  //=================Dispose=============================//
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  dynamic clearText() {
    emailController.clear();
    emailValidate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Recieve an email to reset your password.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
              iconSuffix:
                  emailValidate == false ? Icons.close_sharp : Icons.done),
          //==========================Button Login==================================//
          animationButtonWidget(
            iconButton: Icons.send_to_mobile,
            buttonColor: Colors.blueAccent,
            label: 'Reset Password',
            onClick: () async {
              bool response = getValidate();
              if (response == false) {
                response;
              } else {
                log(emailController.text);

                await resetPassword();
              }
            },
          ),
        ],
      ),
    );
  }

//========================Function Sign In=====================================//
  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      auth
          .sendPasswordResetEmail(
            email: emailController.text.trim(),
          )
          .whenComplete(() => clearText());
      Utils.showSnackBar("Password Reset Email Sent");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (err) {
      Utils.showSnackBar(err.message);
      Navigator.of(context).pop();
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
    }
    return isValid;
  }
}
