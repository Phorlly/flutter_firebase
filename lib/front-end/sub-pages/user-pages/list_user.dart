import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_laravel/back-end/controllers/globals.dart';

import 'package:flutter_laravel/back-end/models/user.dart';
import 'package:flutter_laravel/front-end/sub-pages/user-pages/edit_user.dart';

class ListUserPage extends StatelessWidget {
  final List<User> users;
  final CollectionReference reference = store.collection("Users");
  ListUserPage({required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    final allData = users;
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        DataTable(
          columns: const [
            DataColumn(
              label: Text("Short Name"),
            ),
            DataColumn(
              label: Text("Full Name"),
            ),
            DataColumn(
              label: Text("Position"),
            ),
            DataColumn(
              label: Text("Contact No"),
            ),
            DataColumn(
              label: Text("Action"),
            ),
          ],
          rows: List<DataRow>.generate(
            allData.length,
            (index) => DataRow(
              cells: [
                DataCell(
                  CircleAvatar(
                    child: Text(
                      allData[index].name!.substring(0, 2).toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataCell(
                  Text("${allData[index].name}"),
                ),
                DataCell(
                  Text("${allData[index].position}"),
                ),
                DataCell(
                  Text("${allData[index].contactNo}"),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("${allData[index].name}"),
                                  ));
                        },
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.blueAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditUserPage(user: allData[index]),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.greenAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: "Are sure want to DELETE",
                            desc: "Name this: ${allData[index].name}",
                            btnOkOnPress: () {
                              reference
                                  .doc(allData[index].id)
                                  .delete()
                                  .whenComplete(
                                () {
                                  toaster(
                                      message:
                                          "User has been deleted successfully",
                                      backColor: Colors.green);
                                  Navigator.pushNamed(context, "/users");
                                },
                              );
                            },
                            btnCancelOnPress: () {},
                          ).show();
                          
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
