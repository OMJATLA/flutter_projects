import 'dart:async';

import 'package:cred/Screens/Second%20View%20Screen/second_view_screen.dart';
import 'package:cred/Screens/Third%20View%20Screen/third_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  RxDouble creditAmount = 150000.0.obs;
  RxInt selectedPlanIndex = RxInt(-1);
  RxBool showLoader = true.obs;
  RxBool changeIcon = false.obs;

  increaseAmount(double amount) {
    creditAmount.value = amount.floorToDouble();
  }

  changeLoader(bool value) {
    //dismiss loader
    showLoader.value = value;
  }

  changeicon(Controller controller, bool onOff) {
    // changeIcon.value = value;

    if (onOff) {
      changeIcon.value = false;
    } else {
      changeIcon.value = true;
    }
  }

  loadingTime(Controller controller) {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      controller.changeLoader(false);
      timer.cancel();
    });
  }

  static goToSecondView(Color color, double creditAmount) {
    if (creditAmount != 0) {
      Get.bottomSheet(
        SecondView(creditAmount: creditAmount.floor().toDouble()),
        enableDrag: false,
        barrierColor: Colors.transparent,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } else {
      Fluttertoast.showToast(
        msg: "amount should be greater than 0",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  static goToThirdView(Color color, Controller controller) {
    if (controller.selectedPlanIndex.value != -1) {
      Get.bottomSheet(
        ThirdView(),
        enableDrag: false,
        barrierColor: Colors.transparent,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Select the plan",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }
}
