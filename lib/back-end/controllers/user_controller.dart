import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:flutter_laravel/back-end/models/user.dart';

class UsersController {
  //===================POST: data=========================================//
  static Future<void> addUser(User user, BuildContext context) async {
    try {
      final userDoc = store.collection("Users").doc();
      user.id = userDoc.id;
      var data = user.toJson();

      await userDoc.set(data).whenComplete(
        () {
          toaster(
              message: "User has been created successfully..!",
              backColor: Colors.greenAccent);
          Navigator.pushNamed(context, "/master");
        },
      );
    } on FirebaseException catch (err) {
      Utils.showSnackBar(err.message);
    }
  }

  //===================PUT: data by id=========================================//
  static Future<void> editUser(User user, BuildContext context) async {
    try {
      final userDoc = store.collection("Users").doc(user.id);
      await userDoc
          .update(
        user.toJson(),
      )
          .whenComplete(
        () {
          toaster(
              message: "User has been updated successfully..!",
              backColor: Colors.greenAccent);
          Navigator.pushNamed(context, "/master");
        },
      );
    } on FirebaseException catch (err) {
      Utils.showSnackBar(err.message);
    }
  }
}
