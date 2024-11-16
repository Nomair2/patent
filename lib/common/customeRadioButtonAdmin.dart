import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:patents/controller/admin_controller/adminController.dart';

class CustomeRadioButtonAdmin extends GetView<AdminController> {
  final String label;
  final String value;

  const CustomeRadioButtonAdmin(
      {super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
        builder: (controller) => Row(
              children: [
                Radio<String>(
                  activeColor: Colors.blue,
                  value: value,
                  groupValue: controller.account,
                  onChanged: (String? val) {
                    controller.onChanged(value);
                  },
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ));
  }
}
