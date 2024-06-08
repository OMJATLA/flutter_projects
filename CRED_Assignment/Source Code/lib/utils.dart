import 'package:cred/const.dart';
import 'package:flutter/material.dart';

// circular Avatars
class CircleAvatarWidget extends StatelessWidget {
  final IconData icon;
  final Size mediaSize;
  final Color color;

  const CircleAvatarWidget({
    super.key,
    required this.icon,
    required this.mediaSize,
    this.color = const Color(0xff1C1F24),
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      foregroundColor: Colors.white,
      maxRadius: mediaSize.width * 0.04,
      child: Icon(
        icon,
        size: mediaSize.width * 0.045,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key,
      required this.mediaSize,
      required this.title,
      required this.ontap,
      required this.color});
  final Function() ontap;
  final String title;
  final Size mediaSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        color: color,
        child: Container(
          height: mediaSize.height * 0.09,
          decoration: BoxDecoration(
            color: kBottomNavColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(mediaSize.width * 0.05),
              topRight: Radius.circular(mediaSize.width * 0.05),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: kUnSelectedIndicatorColor,
                  fontSize: mediaSize.height * 0.020),
            ),
          ),
        ),
      ),
    );
  }
}

//  text
class ReUsableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const ReUsableText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.color,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
    );
  }
}

// top circular bottom style

BoxDecoration boxDecoration(Size mediaSize, Color color) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(mediaSize.width * 0.052),
        topRight: Radius.circular(mediaSize.width * 0.052),
      ));
}

// Sized box

class ReUsableSizedBox extends StatelessWidget {
  final double height;
  final double width;

  const ReUsableSizedBox({
    super.key,
    required this.height,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

//App Bar
AppBar appbar(Size mediaSize) {
  return AppBar(
      elevation: 0,
      toolbarHeight: mediaSize.height * 0.1,
      leading: Padding(
        padding: EdgeInsets.all(mediaSize.height * 0.02),
        child: CircleAvatarWidget(icon: Icons.close, mediaSize: mediaSize),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.all(mediaSize.height * 0.02),
            child: CircleAvatarWidget(
                icon: Icons.question_mark_outlined, mediaSize: mediaSize)),
      ],
      backgroundColor: const Color(0xff111419));
}

// loader

loader(Size mediaSize) {
  return Center(
    child: Image(
        height: mediaSize.height * 0.065,
        image: const AssetImage('assets/loader.gif')),
  );
}

// /circle Icon or check (Plan Card, Select Bank )

Widget circleIconOrCheck({
  required Size mediaSize,
  required bool isSelected,
  required ValueSetter<bool> onChanged,
}) {
  return InkWell(
    onTap: () {
      onChanged(!isSelected); // Toggle the selection state.
    },
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius:
              BorderRadius.all(Radius.circular(mediaSize.height * 0.02))),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        maxRadius: mediaSize.width * 0.037,
        child: isSelected
            ? Icon(
                Icons.check,
                size: mediaSize.height * 0.025,
              )
            : const SizedBox(),
      ),
    ),
  );
}
