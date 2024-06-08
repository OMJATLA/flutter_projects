import 'package:cred/const.dart';
import 'package:cred/Controller/controller.dart';
import 'package:cred/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

secondViewCard(Size mediaSize) {
  return ListTile(
    tileColor: kSecondviewColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(mediaSize.height * 0.052),
            topRight: Radius.circular(mediaSize.height * 0.052))),
    onTap: () {
      Get.back();
    },
    title: Row(
      children: [
        ReUsableText(
            text: 'EMI',
            color: kLightTextColor.withOpacity(0.35),
            fontSize: mediaSize.height * 0.0165),
        ReUsableSizedBox(height: 0, width: mediaSize.width * 0.4),
        ReUsableText(
            text: 'Duration',
            color: kLightTextColor.withOpacity(0.35),
            fontSize: mediaSize.height * 0.0165),
      ],
    ),
    subtitle: Row(
      children: [
        ReUsableText(
            text: '₹4,247 /mo',
            color: kLightTextColor.withOpacity(0.35),
            fontSize: mediaSize.height * 0.020),
        ReUsableSizedBox(height: 0, width: mediaSize.width * 0.25),
        ReUsableText(
            text: '12 months',
            color: kLightTextColor.withOpacity(0.35),
            fontSize: mediaSize.height * 0.0165),
      ],
    ),
    trailing: Icon(
      Icons.keyboard_arrow_down_outlined,
      size: mediaSize.height * 0.03,
      color: Colors.white,
    ),
  ).paddingSymmetric(horizontal: mediaSize.width * 0.015);
}

thirdViewContents(Size mediaSize, Controller controller) {
  return Expanded(
    child: Container(
      width: double.infinity,
      decoration: boxDecoration(mediaSize, kThirdviewColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaSize.width * 0.06),
        child:
            // due to Obx render tree will build only this part of widget tree
            Obx(
          () => SizedBox(
            child:
                // if showLoader = true //
                controller.showLoader.value
                    ? loader(mediaSize) //loading icon
                    // if showLoader = false //
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: mediaSize.height * 0.035),
                            child: ReUsableText(
                              text: 'Where should we send the money?',
                              fontSize: mediaSize.width * 0.042,
                              color: kLightTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ReUsableSizedBox(height: mediaSize.height * 0.01),
                          ReUsableText(
                            text:
                                'amount will be credited to this bank account, EMI also be debited from this account',
                            fontSize: mediaSize.width * 0.035,
                            color: kDarkTextColor,
                          ),
                          ReUsableSizedBox(height: mediaSize.height * 0.05),
                          //bank details
                          InkWell(
                            onTap: () {
                              controller.changeicon(controller, false);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: mediaSize.height * 0.063,
                                  width: mediaSize.width * 0.13,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          const AssetImage('assets/hdfc.png'),
                                      scale: mediaSize.height * 0.04,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(mediaSize.width * 0.035),
                                    ),
                                  ),
                                ),
                                SizedBox(width: mediaSize.width * 0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReUsableText(
                                      text: 'HDFC Bank',
                                      fontSize: mediaSize.width * 0.042,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ReUsableSizedBox(
                                        height: mediaSize.height * 0.01),
                                    Text(
                                      '50100117009192',
                                      style: TextStyle(
                                        fontSize: mediaSize.width * 0.042,
                                        color: Colors.grey,
                                        letterSpacing: -1.0,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                CircleAvatarWidget(
                                  icon: Icons.check,
                                  mediaSize: mediaSize,
                                  color: kDarkTextColor,
                                )
                              ],
                            ),
                          ),
                          ReUsableSizedBox(height: mediaSize.height * 0.05),
                          //change account button
                          Container(
                            height: mediaSize.height * 0.050,
                            width: mediaSize.width * 0.32,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kDarkTextColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(mediaSize.width * 0.05),
                              ),
                            ),
                            child: Center(
                              child: ReUsableText(
                                text: 'Change account',
                                fontSize: mediaSize.width * 0.032,
                                color: kLightTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
          ),
        ),
      ),
    ),
  );
}
