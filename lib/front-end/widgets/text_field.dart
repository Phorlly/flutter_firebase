import 'package:flutter/material.dart';

//============================Widget textbox input========================//
Widget textFieldWidget({
  required String? labelText,
  TextInputType? textInputType = TextInputType.name,
  required TextEditingController textController,
  void Function(String)? onChanged,
  FocusNode? focus,
  required bool autoFocus,
  required IconData iconPrefix,
  IconData? iconSuffix,
  required bool isHide,
  bool isValid = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 5),
    child: TextField(
      controller: textController,
      onChanged: onChanged,
      focusNode: focus,
      autofocus: autoFocus,
      obscureText: isHide,
      keyboardType: textInputType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 3,
              color: isValid == false ? Colors.redAccent : Colors.blueAccent),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        prefixIcon: Icon(
          iconPrefix,
          color: Colors.black,
        ),
        suffixIcon: Icon(
          iconSuffix,
          color: isValid == false ? Colors.redAccent : Colors.greenAccent,
        ),
        labelText: "Enter your $labelText",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
      style: const TextStyle(fontSize: 20),
    ),
  );
}
