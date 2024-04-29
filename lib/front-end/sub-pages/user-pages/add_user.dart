import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:flutter_laravel/back-end/controllers/user_controller.dart';
import 'package:flutter_laravel/back-end/models/user.dart';
import 'package:flutter_laravel/front-end/widgets/animattion_button.dart';
import 'package:flutter_laravel/front-end/widgets/circle_avatar.dart';
import 'package:flutter_laravel/front-end/widgets/text.dart';
import 'package:flutter_laravel/front-end/widgets/text_field.dart';
import 'package:validators/validators.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  //===============Declare Variable=======================================//
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final contactNoController = TextEditingController();
  bool nameValidate = false;
  bool positionValidate = false;
  bool contactNoValidate = false;
  final focus = FocusNode();

  //=================Dispose=============================//
  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    contactNoController.dispose();
    focus.dispose();
    super.dispose();
  }

  dynamic clearText() {
    nameController.clear();
    positionController.clear();
    contactNoController.clear();
    nameValidate = false;
    positionValidate = false;
    contactNoValidate = false;
  }

  @override
  Widget build(BuildContext context) {
    // double widthButton=MediaQuery.of(context).size.width;
    double heightConent = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("USER INFOMATION"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
//==========================CircleAvatar==================================//
            circleAvatarWidget(imageUrl: "assets/images/flutter.png"),

//==========================Text Login====================================//
            textWidget(title: "ADD NEW USER"),

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
//==========================Text Field Full Name==================================//
                  textFieldWidget(
                      iconPrefix: Icons.person,
                      autoFocus: true,
                      onChanged: (val) {
                        setState(() {
                          nameValidate = isLength(val, 2, 32);
                        });
                      },
                      labelText: 'full name',
                      isValid: nameValidate,
                      textController: nameController,
                      isHide: false,
                      textInputType: TextInputType.text,
                      iconSuffix: nameValidate == false
                          ? Icons.close_sharp
                          : Icons.done),
//==========================Text Field Position================================//
                  textFieldWidget(
                    iconPrefix: Icons.post_add,
                    onChanged: (val) {
                      setState(() {
                        positionValidate = isLength(val, 2, 32);
                      });
                    },
                    autoFocus: false,
                    labelText: 'position',
                    isValid: positionValidate,
                    iconSuffix: positionValidate == false
                        ? Icons.close_sharp
                        : Icons.done,
                    textController: positionController,
                    isHide: false,
                    textInputType: TextInputType.text,
                    // focus: positionValidate == true ? null : focus,
                  ),
//==========================Text Field Contact Number================================//
                  textFieldWidget(
                    iconPrefix: Icons.phone,
                    onChanged: (val) {
                      setState(() {
                        contactNoValidate = isLength(val, 2, 32);
                      });
                    },
                    autoFocus: false,
                    labelText: 'contact number',
                    isValid: contactNoValidate,
                    iconSuffix: contactNoValidate == false
                        ? Icons.close_sharp
                        : Icons.done,
                    textController: contactNoController,
                    isHide: false,
                    textInputType: TextInputType.phone,
                    // focus: contactNoValidate == true  ? null : focus,
                  ),
//==========================Button Add New==================================//
                  animationButtonWidget(
                    iconButton: Icons.person_add,
                    buttonColor: Colors.blueAccent,
                    label: 'POST DATA',
                    onClick: () async {
                      bool response = getValidate();
                      if (response == false) {
                        response;
                      } else {
                        log(nameController.text);
                        log(positionController.text);
                        log(contactNoController.text);
                        final user = User(
                            name: nameController.text,
                            position: positionController.text,
                            contactNo: contactNoController.text);
                        await UsersController.addUser(user, context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //========================Function Validate=====================================//
  bool getValidate() {
    var isValid = true;
    if (nameController.text.isEmpty) {
      nameValidate = true;
      toaster(message: "Full name cannot null..!", backColor: Colors.red);
      isValid = false;
    } else {
      nameValidate = false;
      if (positionController.text.isEmpty) {
        positionValidate = true;
        toaster(message: "Position cannot null..!", backColor: Colors.red);
        // focus.requestFocus();
        isValid = false;
      } else {
        positionValidate = false;
        if (contactNoController.text.isEmpty) {
          contactNoValidate = true;
          toaster(
              message: "Contact number cannot null..!", backColor: Colors.red);
          // focus.requestFocus();
          isValid = false;
        } else {
          contactNoValidate = false;
        }
      }
    }

    return isValid;
  }
}
