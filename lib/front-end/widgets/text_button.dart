import 'package:flutter/material.dart';

Widget textButtonWidget({required Function() onClick, required String text}) {
  return TextButton(
    onPressed: onClick,
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 18,
          decoration: TextDecoration.underline,
          color: Colors.blueAccent),
    ),
  );
}
