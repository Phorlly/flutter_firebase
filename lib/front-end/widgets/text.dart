import 'package:flutter/material.dart';

Widget textWidget({required String title}) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 27),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    ),
  );
}
