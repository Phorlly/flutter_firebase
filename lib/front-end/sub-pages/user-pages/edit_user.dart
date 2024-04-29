import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/user_controller.dart';
import 'package:flutter_laravel/back-end/models/user.dart';
import 'package:flutter_laravel/front-end/widgets/animattion_button.dart';
import 'package:flutter_laravel/front-end/widgets/circle_avatar.dart';
import 'package:flutter_laravel/front-end/widgets/text.dart';
import 'package:flutter_laravel/front-end/widgets/text_field.dart';

class EditUserPage extends StatelessWidget {
  final User user;
  const EditUserPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    //===============Declare Variable=======================================//
    final nameController = TextEditingController();
    final positionController = TextEditingController();
    final contactNoController = TextEditingController();
    bool nameValidate = false;
    bool positionValidate = false;
    bool contactNoValidate = false;
    // final focus = FocusNode();

    //==============Asign Value Into TextBox===============================//
    nameController.text = "${user.name}";
    positionController.text = "${user.position}";
    contactNoController.text = "${user.contactNo}";

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
            textWidget(title: "EDIT USER"),

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
                    iconButton: Icons.update,
                    buttonColor: Colors.blueAccent,
                    label: 'UPDATE DATA',
                    onClick: () async {
                      final updateUser = User(
                          id: "${user.id}",
                          name: nameController.text,
                          position: positionController.text,
                          contactNo: contactNoController.text);
                      await UsersController.editUser(updateUser, context);
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
}
