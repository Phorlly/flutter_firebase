import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:flutter_laravel/front-end/main-pages/master.dart';
import 'package:flutter_laravel/front-end/main-pages/user.dart';
import 'package:flutter_laravel/front-end/sub-pages/auth-pages/login.dart';
import 'package:flutter_laravel/front-end/sub-pages/auth-pages/register.dart';
import 'package:flutter_laravel/front-end/sub-pages/auth-pages/reset_password.dart';
import 'package:flutter_laravel/front-end/sub-pages/user-pages/add_user.dart';


//=========================Main method for run app=============================//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

//=========================class my app for put material app===================//
class MyApp extends StatelessWidget {
  static var title = "Implement Flutter with Firebase";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: title,
      home: const MainPage(),
      initialRoute: "/",
      routes: {
        "/register": (context) => const RegisterPage(),
        "/login": (context) => const LoginPage(),
        "/reset-password": (context) => const ResetPasswordPage(),
        "/add-user": (context) => const AddUserPage(),
        "/master": (context) => const MasterPage(),
        "/users": (context) => const AllUsersPage(),
      },
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}

//=============================class for check auth user=======================//
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges(),
        initialData: User,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const MasterPage();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong..!",
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
              ),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
