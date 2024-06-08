import 'package:cred/Screens/Third%20View%20Screen/widget.dart';
import 'package:cred/const.dart';
import 'package:cred/Controller/controller.dart';
import 'package:cred/utils.dart';
import 'package:flutter/material.dart';

class ThirdView extends StatelessWidget {
  final Controller controller = Controller();
  ThirdView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    //loading icon time
    controller.loadingTime(controller);
    //third view
    return Container(
      height: mediaSize.height * 0.75,
      // height: mediaSize.height * 0.75,
      decoration: boxDecoration(mediaSize, kSecondviewColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          secondViewCard(mediaSize),
          //third view content
          thirdViewContents(mediaSize, controller),
          //bottomNav
          BottomNavBar(
              color: kThirdviewColor,
              mediaSize: mediaSize,
              title: 'Tap for 1-click KYC',
              ontap: () {}),
        ],
      ),
    );
  }
}
