import 'package:cred/Screens/Second%20View%20Screen/widgets.dart';
import 'package:cred/const.dart';
import 'package:cred/Controller/controller.dart';
import 'package:cred/utils.dart';
import 'package:flutter/material.dart';

class SecondView extends StatelessWidget {
  final Controller controller = Controller();
  final double creditAmount;
  SecondView({
    super.key,
    required this.creditAmount,
  });

  @override
  Widget build(BuildContext context) {
    //loading icon time
    controller.loadingTime(controller);
    final mediaSize = MediaQuery.of(context).size;
    //second view
    return Container(
      height: mediaSize.height * 0.85,
      decoration: boxDecoration(mediaSize, kFirstviewColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          firstViewCard(mediaSize, creditAmount.floorToDouble()),
          //second view contents
          secondViewContents(mediaSize, controller),
          //bottom nav bar
          BottomNavBar(
              color: kSecondviewColor,
              mediaSize: mediaSize,
              title: 'Select bank account',
              ontap: () {
                //goes to third view
                Controller.goToThirdView(Colors.transparent, controller);
              })
        ],
      ),
    );
  }
}
