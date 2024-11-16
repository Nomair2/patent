import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/customTextField.dart';
import '../../common/primareButton.dart';
import '../../common/upperLogo.dart';
import '../../controller/auth_controller/login_controller.dart';
import '../../function/validinput.dart';
import '../../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());

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
                delay: const Duration(milliseconds: 330),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Form(
                    key: controller.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          delay: const Duration(milliseconds: 320),
                          child: Text(
                            "21".tr,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ThemeColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                          icon: const Icon(Icons.lock_outline),
                          onIconPressed: () {},
                          valide: (val) => validInput(val!, 8, "password", ""),
                          title: "9".tr,
                          controller: controller.password,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                              height: 50,
                              width: 170,
                              text: '21'.tr,
                              onTap: () {
                                controller.checkEmail();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.04),
                      ],
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
