import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import '../../common/customTextField.dart';
import '../../common/settings_value.dart';
import '../../controller/investor_controller/profileInvestoreController.dart';
import '../../locale/localeController.dart';
import '../../theme.dart';

class Profileinvestorscreen extends StatelessWidget {
  const Profileinvestorscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileInvestorController());
    Get.put(MyLocalController);
    MyLocalController lang = Get.find();
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("41".tr, style: TextStyle(color: ThemeColor.white)),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileInvestorController>(
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 35),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  curve: Curves.decelerate,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 20),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color:
                                          ThemeColor.primary.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SettingsValue(
                                          name: "7".tr,
                                          icon: Icons.person,
                                          child: Text(
                                            controller.name ?? "Loading...",
                                            // Fallback value
                                            style: TextStyle(
                                                color: ThemeColor.white),
                                          ),
                                          onTap2: () {},
                                        ),
                                        const SizedBox(height: 5),
                                        SettingsValue(
                                          name: "8".tr,
                                          icon: Icons.mail,
                                          child: Text(
                                            controller.email ?? "Loading...",
                                            // Fallback value
                                            style: TextStyle(
                                                color: ThemeColor.white),
                                          ),
                                          onTap2: () {},
                                        ),
                                        const SizedBox(height: 5),
                                        SettingsValue(
                                          name: "9".tr,
                                          icon: Icons.password,
                                          child: Text(
                                            controller.password ?? "Loading...",
                                            // Fallback value
                                            style: TextStyle(
                                                color: ThemeColor.white),
                                          ),
                                          onTap2: () {},
                                        ),
                                        const SizedBox(height: 5),
                                        SettingsValue(
                                          name: "20".tr,
                                          icon: Icons.work,
                                          child: Text(
                                            controller.job ?? "Loading...",
                                            // Fallback value
                                            style: TextStyle(
                                                color: ThemeColor.white),
                                          ),
                                          onTap2: () {},
                                        ),
                                        const SizedBox(height: 5),
                                        SettingsValue(
                                          name: "10".tr,
                                          icon: Icons.location_city,
                                          child: Text(
                                            controller.address ?? "Loading...",
                                            // Fallback value
                                            style: TextStyle(
                                                color: ThemeColor.white),
                                          ),
                                          onTap2: () {},
                                        ),
                                        const SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            _showEditProfileDialog(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: ThemeColor.primary
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: ThemeColor.primary
                                                      .withOpacity(0.15)),
                                            ),
                                            child: Text(
                                              "32".tr,
                                              style: TextStyle(
                                                  color: ThemeColor.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 20),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color:
                                          ThemeColor.primary.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SettingsValue(
                                            name: "54".tr,
                                            icon: Icons.language,
                                            child: SizedBox(),
                                            onTap2: (){ String currentLang = Get.locale!.languageCode;
                                            String newLang;
                                            currentLang == 'ar'
                                                ? {newLang = 'en-US', currentLang = "en"}
                                                : {newLang = 'ar-SA', currentLang = "ar"};
                                            lang.changeLanguage(currentLang);}),
                                        SettingsValue(
                                          name: "2".tr,
                                          icon: Icons.logout_outlined,
                                          child: const SizedBox(),
                                          onTap2: () {
                                            showPlatformDialog(
                                              context: context,
                                              builder: (context) =>
                                                  BasicDialogAlert(
                                                title: Text("3".tr),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      BasicDialogAction(
                                                        title: Text("4".tr),
                                                        onPressed: () {
                                                          controller.logout();
                                                        },
                                                      ),
                                                      BasicDialogAction(
                                                        title: Text("5".tr),
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        SettingsValue(
                                          name: "33".tr,
                                          icon: Icons.delete,
                                          child: const SizedBox(),
                                          onTap2: () {
                                            showPlatformDialog(
                                              context: context,
                                              builder: (context) =>
                                                  BasicDialogAlert(
                                                title: Text("34".tr),
                                                actions: <Widget>[
                                                  BasicDialogAction(
                                                    title: Text("4".tr),
                                                    onPressed: () {
                                                      controller
                                                          .deleteInvestor();
                                                    },
                                                  ),
                                                  BasicDialogAction(
                                                    title: Text("5".tr),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) async {
    Get.find<ProfileInvestorController>().jobC.text =
        Get.find<ProfileInvestorController>().job!;
    Get.find<ProfileInvestorController>().nameC.text =
        Get.find<ProfileInvestorController>().name!;
    Get.find<ProfileInvestorController>().addressC.text =
        Get.find<ProfileInvestorController>().address!;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GetBuilder<ProfileInvestorController>(
            builder: (controller) => AlertDialog(
                  content: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFieldWithoutIcon(
                          onIconPressed: () {},
                          title: "7".tr,
                          controller: controller.nameC,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldWithoutIcon(
                          onIconPressed: () {},
                          title: "20".tr,
                          controller: controller.jobC,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldWithoutIcon(
                          onIconPressed: () {},
                          title: "10".tr,
                          controller: controller.addressC,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text('5'.tr),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text('35'.tr),
                          onPressed: () {
                            // Save the changes here
                            controller.updataInvestor();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ],
                ));
      },
    );
  }
}
