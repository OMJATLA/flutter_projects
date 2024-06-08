import 'package:cred/Screens/First%20View%20Screen/widgets.dart';
import 'package:cred/const.dart';
import 'package:cred/Controller/controller.dart';
import 'package:cred/utils.dart';
import 'package:flutter/material.dart';

// Start.....

class FirstView extends StatefulWidget {
  const FirstView({Key? key}) : super(key: key);

  @override
  State<FirstView> createState() => _FirstViewState();
}

class _FirstViewState extends State<FirstView> {
  Controller controller = Controller();
  //build
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff111419),
      body: Column(
        children: [
          //top bar
          TopView(mediaSize: mediaSize),
          //Content, Inside Contianer (white), Circular Silder........
          Content(mediaSize: mediaSize, controller: controller),
        ],
      ),
      // bottom Nav Bar
      bottomNavigationBar: BottomNavBar(
          color: kSecondviewColor,
          mediaSize: mediaSize,
          title: 'Proceed to EMI selection',
          ontap: () {
            //goes to second view
            Controller.goToSecondView(Colors.transparent,
                controller.creditAmount.value.floorToDouble());
          }),
    );
  }
}
//



