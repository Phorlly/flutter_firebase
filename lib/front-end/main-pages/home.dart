
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightSizeBox = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Image.asset("assets/images/happy.gif"),
        SizedBox(
          height: heightSizeBox / 5,
          child: const Center(
            child: Text(
              "Home Page",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
        ),
        // AnimatedButton(
        //   text: "Success",
        //   icon: Icons.check,
        //   width: 300,
        //   color: Colors.green,
        //   buttonTextStyle: const TextStyle(fontSize: 25),
        //   pressEvent: () {
        //     AwesomeDialog(
        //         context: context,
        //         dialogType: DialogType.success,
        //         animType: AnimType.topSlide,
        //         showCloseIcon: true,
        //         title: "Success",
        //         desc: "This is the description of the awesome dialog box",
        //         btnOkOnPress: () {
        //           auth.signOut().whenComplete(
        //               () => Navigator.popAndPushNamed(context, "/welcome"));
        //         }).show();
        //   },
        // ),
      ],
    );
  }
}
