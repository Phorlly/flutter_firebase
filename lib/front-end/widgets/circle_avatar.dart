import 'package:flutter/material.dart';

Widget circleAvatarWidget({required String imageUrl}) {
  return  Padding(
    padding: const EdgeInsets.only(top: 58.0),
    child: CircleAvatar(
      backgroundImage: AssetImage(imageUrl),
      radius: 56,
    ),
  );
}
