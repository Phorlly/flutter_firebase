//==================Widget Button========================================//
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Widget animationButtonWidget(
    {IconData? iconButton,
    required String label,
    Color? buttonColor,
    required void Function() onClick}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AnimatedButton(
      text: label,
      icon: (iconButton),
      width: 350,
      color: buttonColor,
      buttonTextStyle: const TextStyle(fontSize: 20),
      pressEvent: onClick,
    ),
  );
}

// ElevatedButton.icon(
//     onPressed: onClick,
//     icon: Icon(iconButton),
//     label: Text(
//       label,
//       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//     ),
//     style: ButtonStyle(
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//       ),
//     ),
//   );
 