import 'package:flutter/material.dart';
import '../theme.dart';

class UpperLogo extends StatelessWidget {
  const UpperLogo({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 20),
      height: height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: const Image(image: AssetImage("assets/images/Logo_patent.png")),
    );
  }
}
