import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patents/locale/localeController.dart';
import 'package:patents/view/visitorview/bottomVarBarVisitor.dart';
import '../common/primareButton.dart';
import '../common/upperLogo.dart';
import '../theme.dart';
import 'auth/loginScreen.dart';
import 'auth/signUpScreen/signUpAowner.dart';
import 'auth/signUpScreen/signUpInvestor.dart';

class SelecetAccount extends StatelessWidget {
  const SelecetAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Get.put(MyLocalController);
    MyLocalController lang = Get.find();
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
              SizedBox(height: height * 0.08),
              FadeInDown(
                delay: const Duration(milliseconds: 320),
                child: Text(
                  "42".tr,
                  style: TextStyle(
                      color: ThemeColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              const SizedBox(height: 15),
              FadeInDown(
                  delay: const Duration(milliseconds: 340),
                  child: PrimaryButton(
                      width: 150,
                      height: 50,
                      onTap: () {
                        Get.to(const OwnerSignUp());
                      },
                      text: "43".tr)),
              const SizedBox(height: 15),
              FadeInDown(
                  delay: const Duration(milliseconds: 360),
                  child: PrimaryButton(
                      height: 50,
                      width: 150,
                      onTap: () {
                        Get.to(const InvestorSginUp());
                      },
                      text: "13".tr)),
              const SizedBox(height: 15),
              FadeInDown(
                  delay: const Duration(milliseconds: 360),
                  child: PrimaryButton(
                      height: 50,
                      width: 150,
                      onTap: () {
                        Get.offAll(const BottomNavBarVisitor());
                      },
                      text: "44".tr)),
              FadeInDown(
                delay: const Duration(milliseconds: 370),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "45".tr,
                      style: TextStyle(
                          color: ThemeColor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      child: Text(
                        "21".tr,
                        style: TextStyle(
                            color: ThemeColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  String currentLang = Get.locale!.languageCode;
                  String newLang;
                  currentLang == 'ar'
                      ? {newLang = 'en-US', currentLang = "en"}
                      : {newLang = 'ar-SA', currentLang = "ar"};
                  lang.changeLanguage(currentLang);
                },
                child:  Text(
                  "54".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
