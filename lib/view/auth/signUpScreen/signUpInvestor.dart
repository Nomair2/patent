import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/customTextField.dart';
import '../../../common/primareButton.dart';
import '../../../common/upperLogo.dart';
import '../../../controller/auth_controller/investor_signup_controller.dart';
import '../../../function/validinput.dart';
import '../../../theme.dart';

class InvestorSginUp extends StatefulWidget {
  const InvestorSginUp({super.key});

  @override
  State<InvestorSginUp> createState() => _InvestorSginUpState();
}

class _InvestorSginUpState extends State<InvestorSginUp> {
  InvestorSignupController controller = Get.put(InvestorSignupController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                  delay: const Duration(milliseconds: 300),
                  child: UpperLogo(width: width, height: height)),
              SizedBox(height: height * 0.04),
              FadeInDown(
                delay: const Duration(milliseconds: 320),
                child: Text(
                  "19".tr,
                  style: TextStyle(
                      color: ThemeColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              const SizedBox(height: 15),
              FadeInDown(
                delay: const Duration(milliseconds: 330),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Obx(
                    () => Form(
                      key: controller.key,
                      child: Column(
                        children: [
                          CustomTextField(
                            icon: const Icon(Icons.person_3_outlined),
                            onIconPressed: () {},
                            title: "7".tr,
                            valide: (val) => validInput(val!, 1, "name", ""),
                            controller: controller.name,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            icon: const Icon(Icons.mail_outline),
                            onIconPressed: () {},
                            title: "8".tr,
                            valide: (val) => validInput(val!, 1, "email", ""),
                            controller: controller.email,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            icon: const Icon(Icons.work_outline),
                            onIconPressed: () {},
                            title: "20".tr,
                            valide: (val) => validInput(val!, 1, "job", ""),
                            controller: controller.job,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            icon: const Icon(Icons.lock_outline),
                            onIconPressed: () {},
                            valide: (val) =>
                                validInput(val!, 8, "password", ""),
                            title: "9".tr,
                            controller: controller.password,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            icon: const Icon(Icons.location_on_outlined),
                            onIconPressed: () {},
                            valide: (val) => validInput(val!, 1, "address", ""),
                            title: "10".tr,
                            controller: controller.address,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                '15'.tr + " ${controller.gender.value}",
                                style: TextStyle(color: ThemeColor.white),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio<String>(
                                    activeColor: Colors.blue,
                                    value: 'Male',
                                    groupValue: controller.gender.value,
                                    onChanged: (String? value) {
                                      setState(() {
                                        controller.gender.value = value!;
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
                                    groupValue: controller.gender.value,
                                    onChanged: (String? value) {
                                      setState(() {
                                        controller.gender.value = value!;
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
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            height: 50,
                            width: 170,
                            text: '18'.tr,
                            onTap: () {
                              controller.signup();
                            },
                          ),
                          SizedBox(height: height * 0.04),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
