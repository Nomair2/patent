import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

class GenderSelection extends StatefulWidget {
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String? selectedGender = "Male";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          '${'15'.tr}$selectedGender',
          style: TextStyle(color: ThemeColor.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              activeColor: Colors.blue,
              value: 'Male',
              groupValue: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            const SizedBox(width: 20),
            Text(
              '16'.tr,
              style: TextStyle(color: ThemeColor.white),
            ),
            Radio<String>(
              value: 'Female',
              activeColor: Colors.blue,
              groupValue: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            const SizedBox(width: 20),
            Text(
              '17'.tr,
              style: TextStyle(color: ThemeColor.white),
            ),
          ],
        ),
      ],
    );
  }
}
