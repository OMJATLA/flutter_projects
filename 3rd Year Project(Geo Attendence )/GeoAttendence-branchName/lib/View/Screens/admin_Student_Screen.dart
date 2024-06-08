import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/colors.dart';
import '../../Widgets/widgets.dart';

class AdminStudentScreen extends StatefulWidget {
  const AdminStudentScreen({super.key});

  @override
  State<AdminStudentScreen> createState() => _AdminStudentScreenState();
}

class _AdminStudentScreenState extends State<AdminStudentScreen> {
  bool isUserLoggedIn = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminstubackGroundGradientColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                      tag: 'image',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                            Image.asset('assets/images/login.png', height: 100),
                      )),
                  // Text(
                  //   "Geo\nAttendence",
                  //   style: TextStyle(
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //       color: darkBlue),
                  // ),
                  AnimatedTextKit(
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      ColorizeAnimatedText("Geo\nAttendence",
                          textStyle: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                          ),
                          colors: colorizeColors)
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ReuseableMaterialButton(
                clr: Colors.white,
                heroTag: 'adminTag',
                width: double.infinity,
                buttonText: 'Admin',
                callback: () {
                  Get.toNamed('/loginPage', arguments: ['Admin Login']);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ReuseableMaterialButton(
                heroTag: 'studentTag',
                clr: lightOrange,
                width: double.infinity,
                buttonText: 'Student',
                callback: () {
                  Get.toNamed('/loginPage', arguments: ['Student Login']);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
