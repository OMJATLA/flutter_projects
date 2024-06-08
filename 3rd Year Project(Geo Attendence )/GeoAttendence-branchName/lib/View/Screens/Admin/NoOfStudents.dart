import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/colors.dart';
import '../../../Widgets/widgets.dart';

class NoOfStuds extends StatefulWidget {
  const NoOfStuds({super.key});

  @override
  State<NoOfStuds> createState() => _NoOfStudsState();
}

class _NoOfStudsState extends State<NoOfStuds> {
  String title = Get.arguments[0];

  DatabaseReference ref1 = FirebaseDatabase.instance.ref('Students');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: StudentsbackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: darkBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                  query: ref1,
                  itemBuilder: (context, snapshot, animation, index) {
                    print(snapshot.child('status').value.toString());
                    var status = snapshot.child('status').value.toString();
                    return Card(
                      surfaceTintColor: Colors.white,
                      color: title == "Students"
                          ? Colors.white
                          : status == 'present'
                              ? const Color.fromARGB(255, 112, 206, 115)
                              : const Color.fromARGB(255, 238, 91, 81),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: ListTile(
                        title: Text("Name : ${snapshot.child('name').value}"),
                        trailing: Text(
                            "Roll no : ${snapshot.child('roll_no').value}"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
