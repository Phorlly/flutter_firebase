import 'package:flutter/material.dart';

Widget listTileWidget({
  required String titile,
  void Function()? onTap,
  IconData? iconButton,
}) {
  return ListTile(
    title: Text(
      titile,
      style: const TextStyle(fontSize: 16),
    ),
    onTap: onTap,
    leading: Icon(iconButton, size: 30),
  );
}
