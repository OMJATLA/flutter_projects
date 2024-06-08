import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/widgets.dart';
import '../../../utils/getting_gmail.dart';
import '../admin_Student_Screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool checkAttendence = false;
  final databaseref = FirebaseDatabase.instance.ref('admins');
  int? id;
  Position? position;

  Future getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  @override
  void initState() {
    super.initState();
    getadid().then((value) async {
      id = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminbackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: appBarButton(
              iconData: Icons.logout,
              callBack: () async {
                await auth.signOut();
                Get.to(const AdminStudentScreen());
              },
              iconColor: lightOrange),
          title: const Text(
            'Admin',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: darkBlue,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    checkAttendence
                        ? Get.snackbar('Please! Press Check Attendence ',
                            'to get inactive', backgroundColor: Colors.white)
                        : Get.snackbar(
                            'Please! Press Check Attendence ', 'to get Active',
                            backgroundColor: Colors.white);
                  },
                  child: Text(
                    checkAttendence ? 'Active' : 'Inactive',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  HomeReuseableMaterialButton(
                      clr: lightOrange,
                      height: 80,
                      width: 200,
                      buttonText: 'No of Students',
                      callback: () {
                        Get.toNamed('/allStudents', arguments: ["Students"]);
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  HomeReuseableMaterialButton(
                      clr: checkAttendence ? Colors.red : lightOrange,
                      height: 80,
                      width: 200,
                      buttonText: checkAttendence
                          ? 'Stop Attendence'
                          : 'Check Attendence',
                      callback: () async {
                        await Geolocator.requestPermission();

                        setState(() {
                          checkAttendence
                              ? checkAttendence = false
                              : checkAttendence = true;
                        });

                        //all students long lat and status will be absent
                        await resetStudentData();
                        Timer.periodic(const Duration(seconds: 3),
                            (timer) async {
                          if (checkAttendence == false) timer.cancel();
                          await getLocation();
                          databaseref.child(id.toString()).update({
                            'latitute': position!.latitude,
                            'longitude': position!.longitude,
                          });
                        });
                      }),
                ],
              ),
              checkAttendence ? rippleAnimation() : const SizedBox(),
              ReuseableMaterialButton(
                width: double.infinity,
                buttonText: "Mark Attendenece",
                callback: () {
                  if (checkAttendence) bottomSheet();
                },
                heroTag: "",
                clr: checkAttendence ? Colors.green : Colors.grey,
              ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: checkAttendence ? Colors.green : Colors.grey,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: TextButton(
              //     child: Text(
              //       'Mark Attendenece',
              //       style: TextStyle(
              // color: checkAttendence
              //     ? Colors.black
              //     : const Color.fromARGB(255, 117, 114, 114)),
              //     ),
              //     onPressed: () {
              //       if (checkAttendence) bottomSheet();
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
