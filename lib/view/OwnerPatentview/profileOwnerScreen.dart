import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import '../../common/customTextField.dart';
import '../../common/settings_value.dart';
import '../../controller/owner_controller/profile_owner_controller.dart';
import '../../locale/localeController.dart';
import '../../model/owner_model.dart';
import '../../theme.dart';

class ProfileOwnerscreen extends StatefulWidget {
  const ProfileOwnerscreen({super.key});

  @override
  State<ProfileOwnerscreen> createState() => _ProfileOwnerscreenState();
}

class _ProfileOwnerscreenState extends State<ProfileOwnerscreen> {
  ProfileOwnerController controller = Get.put(ProfileOwnerController());

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocalController);
    MyLocalController lang = Get.find();
    return Scaffold(
      backgroundColor: ThemeColor.background,
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ThemeColor.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "41".tr,
          style: TextStyle(color: ThemeColor.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              child: Obx(
                () => Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: media.width * 1,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 20),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 15,
                                      right: 15,
                                      bottom: 15,
                                      left: 2.5),
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primary.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    children: [
                                      SettingsValue(
                                        name: "7".tr,
                                        icon: Icons.person,
                                        child: Text(
                                          controller.owner.value.name!,
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
                                          controller.owner.value.email!,
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
                                          controller.owner.value.password!,
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
                                          controller.owner.value.address!,
                                          style: TextStyle(
                                              color: ThemeColor.white),
                                        ),
                                        onTap2: () {},
                                      ),
                                      const SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          _showEditProfileDialog(
                                              context, controller.owner.value);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              right: 15,
                                              left: 15),
                                          decoration: BoxDecoration(
                                              color: ThemeColor.primary
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: ThemeColor.primary
                                                      .withOpacity(0.15))),
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
                              ]),
                            ),
                            Container(
                              // height: media.width * 1,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 20),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: ThemeColor.primary.withOpacity(0.4),
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
                                                        Navigator.pop(context);
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
                                                    controller.deleteOwner();
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
                              ]),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, OwnerModel owner) async {
    controller.name.text = owner.name!;
    controller.address.text = owner.address!;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  title: "7".tr,
                  controller: controller.name,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  title: "10".tr,
                  controller: controller.address,
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
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('35'.tr),
                  onPressed: () {
                    controller.updataOwner();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
