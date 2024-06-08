import 'package:cred/const.dart';
import 'package:cred/Controller/controller.dart';
import 'package:cred/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

firstViewCard(Size mediaSize, double creditAmount) {
  return ListTile(
    tileColor: kFirstviewColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(mediaSize.height * 0.052),
            topRight: Radius.circular(mediaSize.height * 0.052))),
    onTap: () {
      Get.back();
    },
    title: ReUsableText(
        text: 'credit amount',
        color: kLightTextColor.withOpacity(0.35),
        fontSize: mediaSize.height * 0.0165),
    subtitle: ReUsableText(
        text: '₹${NumberFormat("#,##,###").format(creditAmount)}',
        color: kLightTextColor.withOpacity(0.35),
        fontSize: mediaSize.height * 0.020),
    trailing: Icon(
      Icons.keyboard_arrow_down_outlined,
      size: mediaSize.height * 0.03,
      color: Colors.white,
    ),
  ).paddingSymmetric(horizontal: mediaSize.width * 0.015);
}

secondViewContents(Size mediaSize, Controller controller) {
  return Expanded(
    child: Container(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: mediaSize.width * 0.06),
      decoration: boxDecoration(mediaSize, kSecondviewColor),
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
                            text: 'How do you wish to repay?',
                            fontSize: mediaSize.height * 0.020,
                            color: kLightTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ).paddingSymmetric(horizontal: mediaSize.width * 0.06),
                        ReUsableSizedBox(
                          height: mediaSize.height * 0.01,
                        ).paddingSymmetric(horizontal: mediaSize.width * 0.06),
                        ReUsableText(
                          text:
                              'choose one of our recommanded plan or make your own',
                          fontSize: mediaSize.height * 0.0165,
                          color: kDarkTextColor,
                        ).paddingSymmetric(horizontal: mediaSize.width * 0.06),
                        ReUsableSizedBox(
                            height: mediaSize.height * 0.03, width: 0),
                        //plans
                        SizedBox(
                          height: mediaSize.height * 0.19,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              //resusable card
                              return PlanDetailsCard(
                                  index: index, controller: controller);
                            },
                          ),
                        ).paddingOnly(left: mediaSize.width * 0.06),
                        ReUsableSizedBox(
                          height: mediaSize.height * 0.02,
                        ).paddingSymmetric(horizontal: mediaSize.width * 0.06),
                        Container(
                          height: mediaSize.height * 0.050,
                          width: mediaSize.width * 0.4,
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
                              text: 'Create your own plan',
                              fontSize: mediaSize.width * 0.032,
                              color: kLightTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ).paddingSymmetric(horizontal: mediaSize.width * 0.06),
                      ],
                    ),
        ),
      ),
    ),
  );
}

// calculation card

// Inside the PlanCard widget
class PlanCard extends StatefulWidget {
  const PlanCard(
      {super.key,
      required this.index,
      required this.onTap,
      required this.controller});

  final int index;
  final VoidCallback onTap;
  final Controller controller;

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap,
      child: Obx(
        () => Container(
          width: mediaSize.width * 0.4,
          margin: EdgeInsets.only(right: mediaSize.width * 0.033),
          padding: EdgeInsets.all(mediaSize.width * 0.045),
          decoration: BoxDecoration(
            color: (widget.index & 1 == 0
                ? const Color(0xff44343E)
                : const Color(0xff7C7390)),
            borderRadius:
                BorderRadius.all(Radius.circular(mediaSize.height * 0.015)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              circleIconOrCheck(
                mediaSize: mediaSize,
                isSelected: widget.index ==
                    widget.controller.selectedPlanIndex
                        .value, // Check if this plan is selected
                onChanged: (selected) {
                  if (selected) {
                    widget.controller.selectedPlanIndex.value = widget.index;
                  }
                },
              ),
              ReUsableSizedBox(
                height: mediaSize.height * 0.016,
              ),
              Row(
                children: [
                  Text(
                    '₹ 4,247',
                    style: TextStyle(
                      fontSize: mediaSize.width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ReUsableText(
                    text: ' /mo',
                    fontSize: mediaSize.width * 0.033,
                    color: Colors.white,
                  ),
                ],
              ),
              ReUsableText(
                text: 'for 12 months',
                fontSize: mediaSize.width * 0.033,
                color: Colors.white,
              ),
              ReUsableSizedBox(
                height: mediaSize.height * 0.015,
              ),
              Text(
                'see calculations',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                  fontSize: mediaSize.width * 0.028,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Inside the PlanDetailsCard widget
class PlanDetailsCard extends StatelessWidget {
  const PlanDetailsCard(
      {super.key, required this.index, required this.controller});

  final int index;
  final Controller controller;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        PlanCard(
            index: index,
            onTap: () {
              // Notify the controller of the selected plan index
              controller.selectedPlanIndex.value = index;
            },
            controller: controller),
        Positioned(
          left: mediaSize.width * 0.05,
          child: index == 1
              ? Container(
                  height: mediaSize.height * 0.03,
                  width: mediaSize.width * 0.3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 12,
                    right: 12,
                  ),
                  child: const Text(
                    'recommended',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
