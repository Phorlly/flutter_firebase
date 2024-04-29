import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/front-end/widgets/list_tile.dart';


Widget drawerMenuWidget({required String? emailAddress}) {
  return Column(
    children: [
      UserAccountsDrawerHeader(
        accountName: const Text(
          textAlign: TextAlign.center,
          'Your Account',
          style: TextStyle(fontSize: 21.0),
        ),
        accountEmail: Text(
          "Your email: ${emailAddress!}",
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        otherAccountsPictures: const [
          Icon(
            Icons.brightness_2_outlined,
            color: Colors.white,
          )
        ], //otherAccountPicture
        currentAccountPicture: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/cr7.png"),
          radius: 70,
        ),
      ),
      listTileWidget(
        titile: "Members",
        onTap: () {},
        iconButton: Icons.person_2
      ),
      listTileWidget(
        titile: "List Items",
        onTap: () {},
        iconButton: Icons.list_alt
      ),
      listTileWidget(
        titile: "About Us",
        onTap: () {},
        iconButton: Icons.help
      ),
      listTileWidget(
        titile: "Settings",
        onTap: () {},
        iconButton: Icons.settings
      ),
      listTileWidget(
        titile: "Sign Out",
        onTap: () => FirebaseAuth.instance.signOut(),
        iconButton: Icons.logout
      ),
    ],
  );
}
