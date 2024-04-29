import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';
import 'package:flutter_laravel/back-end/models/user.dart';
import 'package:flutter_laravel/front-end/sub-pages/user-pages/list_user.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  List<User> allData = [];
  final CollectionReference users = store.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: users.orderBy("Name", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong..!",
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
              ),
            );
          } else if (snapshot.hasData) {
            allData = snapshot.data!.docs
                .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            return ListUserPage(users: allData);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.person_add,
          color: Colors.blue,
          size: 40,
        ),
        onPressed: () => Navigator.pushNamed(context, "/add-user"),
      ),
    );
  }
}

// // class UserPage extends StatelessWidget {
//   const UserPage({super.key});
//   static var title = "Users Manage";

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(
//                   Icons.supervised_user_circle_sharp,
//                   size: 25,
//                 ),
//                 text: "Add New",
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.edit_attributes,
//                   size: 25,
//                 ),
//                 text: "Users",
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.search,
//                   size: 25,
//                 ),
//                 text: "Search",
//               ),
//             ],
//           ),
//         ),
//         body:  const TabBarView(
//           children: [
//             Center(
//               child: Text("Page 1"),
//             ),
//             AddUserPage(),
//             Center(
//               child: Text("Page 1"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
