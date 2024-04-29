import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_laravel/front-end/main-pages/app.dart';
import 'package:flutter_laravel/front-end/main-pages/book.dart';
import 'package:flutter_laravel/front-end/main-pages/home.dart';
import 'package:flutter_laravel/front-end/main-pages/movie.dart';
import 'package:flutter_laravel/front-end/main-pages/user.dart';
import 'package:flutter_laravel/front-end/widgets/drawer_menu.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  int selectedIndex = 0;
  List<Widget> listWidgets = [
    const AllUsersPage(),
    const HomePage(),
    const AppPage(),
    const MoviePage(),
    const BookPage()
  ];

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter App with Firebase"),
      ),
      body: listWidgets[selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.person, title: 'Users'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.apps, title: 'Apps'),
          TabItem(icon: Icons.movie, title: 'Movies'),
          TabItem(icon: Icons.book, title: 'Books'),
        ],
        onTap: onItemTapped,
        activeColor: Colors.white,
        backgroundColor: Colors.teal,
        style: TabStyle.react,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            drawerMenuWidget(emailAddress: user.email),
          ],
        ),
      ),
    );
  }

  void onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
