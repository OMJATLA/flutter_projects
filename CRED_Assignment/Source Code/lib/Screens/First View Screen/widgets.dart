import 'package:cred/const.dart';
import 'package:cred/Controller/controller.dart';
import 'package:cred/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

// Top view (x and ? icons)
class TopView extends StatelessWidget {
  final Size mediaSize;

  const TopView({super.key, required this.mediaSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kTopBarColor,
      padding: EdgeInsets.symmetric(horizontal: mediaSize.width * 0.055),
      height: mediaSize.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatarWidget(icon: Icons.close, mediaSize: mediaSize),
          CircleAvatarWidget(
              icon: Icons.question_mark_outlined, mediaSize: mediaSize),
        ],
      ),
    );
  }
}

// Middle content
class Content extends StatelessWidget {
  final Size mediaSize;
  final Controller controller;

  const Content({super.key, required this.mediaSize, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: mediaSize.height,
          width: double.infinity,
          decoration: boxDecoration(mediaSize, kFirstviewColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaSize.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: mediaSize.height * 0.035),
                  child: ReUsableText(
                    text: 'nikunj, How much do you need ?',
                    fontSize: mediaSize.height * 0.020,
                    color: kLightTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ReUsableSizedBox(
                  height: mediaSize.height * 0.01,
                ), // Modified
                ReUsableText(
                  text:
                      'move the dial and set an amount you need up to ₹ 487,891',
                  fontSize: mediaSize.height * 0.0165,
                  color: kDarkTextColor,
                ),
                ReUsableSizedBox(height: mediaSize.height * 0.042), // Modified
                InnerContainer(mediaSize: mediaSize, controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Inner Container (white and Circular Slider)
class InnerContainer extends StatefulWidget {
  final Size mediaSize;
  final Controller controller;

  const InnerContainer(
      {super.key, required this.mediaSize, required this.controller});

  @override
  State<InnerContainer> createState() => _InnerContainerState();
}

class _InnerContainerState extends State<InnerContainer> {
  TextEditingController textEditingController = TextEditingController();
  double angleMark = 270;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize the text field with formatted value
    textEditingController.text = NumberFormat("#,##,###")
        .format(widget.controller.creditAmount.value.floorToDouble().toInt());
  }

  @override
  Widget build(BuildContext context) {
    const double maxLimit = 487891;
    const double minLimit = 0;

    return Container(
      height: widget.mediaSize.height * 0.53,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(widget.mediaSize.width * 0.08),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.mediaSize.width * 0.05,
          vertical: widget.mediaSize.height * 0.03,
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Circular slider
            Stack(
              children: [
                ReUsableSizedBox(height: widget.mediaSize.height * 0.4),
                SizedBox(
                  height: widget.mediaSize.height * 0.4,
                  child: Obx(
                    () => SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                        minimum: minLimit,
                        maximum: maxLimit,
                        startAngle: 270,
                        endAngle: 270,
                        showLabels: false,
                        showTicks: false,
                        radiusFactor: widget.mediaSize.height * 0.00112,
                        axisLineStyle: AxisLineStyle(
                          color: kUnSelectedIndicatorColor,
                          thickness: widget.mediaSize.width * 0.035,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: widget.controller.creditAmount.value
                                .floorToDouble(),
                            width: widget.mediaSize.width * 0.035,
                            color: kSelectedIndicatorColor,
                          ),
                          MarkerPointer(
                            value: widget.controller.creditAmount.value
                                .floorToDouble(),
                            enableDragging: true,
                            onValueChanged: (value) {
                              widget.controller.increaseAmount(value);
                              // Update the TextFormField text when the MarkerPointer value changes.
                              textEditingController.text =
                                  '₹${NumberFormat("#,##,###").format(value)}';
                            },
                            markerHeight: 30,
                            markerWidth: 30,
                            markerType: MarkerType.circle,
                            color: kPointerColor,
                          )
                        ],
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: widget.mediaSize.height * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReUsableText(
                          text: 'credit amount',
                          fontSize: widget.mediaSize.height * 0.017,
                          color: kLightTextColor,
                        ),
                        SizedBox(
                          width: widget.mediaSize.width * 0.3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            controller: textEditingController,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                              decorationColor: Colors.grey,
                              fontSize: widget.mediaSize.height * 0.032,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            cursorColor: kSelectedIndicatorColor,
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Hide the underline
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                                  int flag = 0;
                                  // Inside the TextInputFormatter.withFunction block
                                  final numericValue =
                                      double.tryParse(newValue.text) ?? 0.0;
                                  widget.controller.creditAmount.value =
                                      numericValue.floor().toDouble();
                                  if (numericValue > maxLimit) {
                                    flag = 1;
                                  }
                                  widget.controller.creditAmount.value =
                                      numericValue.floor().toDouble();
                                  if (flag == 1) {
                                    widget.controller.creditAmount.value =
                                        maxLimit;
                                  }

                                  final formattedValue = flag == 1
                                      ? '₹${NumberFormat("#,##,###").format(maxLimit)}'
                                      : numericValue == 0.0
                                          ? '₹${NumberFormat("#,##,###").format(minLimit)}'
                                          : '₹${NumberFormat("#,##,###").format(numericValue)}';

                                  return TextEditingValue(
                                    text: formattedValue,
                                    selection: TextSelection.collapsed(
                                        offset: formattedValue.length),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ReUsableText(
                          text: '@1.04% monthly',
                          fontSize: widget.mediaSize.height * 0.012,
                          color: const Color.fromARGB(255, 107, 173, 76),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            ReUsableSizedBox(height: widget.mediaSize.height * 0.02),
            Text(
              'Stash is instant. Money will be credited within seconds.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.mediaSize.height * 0.016,
                color: kLightTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
