import 'package:animate_do/animate_do.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:patents/controller/admin_controller/adminController.dart';
import 'package:patents/view/auth/loginScreen.dart';
import '../../common/customTextField.dart';
import '../../common/customeRadioButtonAdmin.dart';
import '../../function/validinput.dart';
import '../../theme.dart';

class BottomNavBarAdmin extends GetView<AdminController> {
  const BottomNavBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());
    return SafeArea(
        child: GetBuilder<AdminController>(
      builder: (controller) => Scaffold(
        backgroundColor: ThemeColor.background,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeColor.primary,
          title: ZoomIn(
            delay: const Duration(milliseconds: 150),
            child: Text("1".tr,
                style: TextStyle(color: ThemeColor.white, fontSize: 23)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 15),
              child: Row(
                children: [
                  Text(
                    "2".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  ZoomIn(
                      child: IconButton(
                          onPressed: () {
                            showPlatformDialog(
                              context: context,
                              builder: (context) => BasicDialogAlert(
                                title: Text("3".tr),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      BasicDialogAction(
                                        title: Text("4".tr),
                                        onPressed: () {
                                          Get.offAll(LoginScreen());
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
                          icon: Icon(
                            Icons.logout,
                            color: ThemeColor.white,
                          ))),
                ],
              ),
            )
          ],
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              buttonColor: Colors.blueAccent,
              onConfirm: () {
                controller.addUser();
              },
              onCancel: () {
                Get.back();
              },
              title: "6".tr,
              content: Form(
                key: controller.key,
                child: SingleChildScrollView(
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
                        valide: (val) => validInput(val!, 1, "email", ""),
                        title: "8".tr,
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
                      const SizedBox(height: 10),
                      CustomTextField(
                        icon: const Icon(Icons.location_on_outlined),
                        onIconPressed: () {},
                        title: "10".tr,
                        valide: (val) => validInput(val!, 1, "address", ""),
                        controller: controller.address,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "11 ".tr + "${controller.account}",
                            style: TextStyle(color: ThemeColor.white),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomeRadioButtonAdmin(
                                value: 'Owner',
                                label: '12'.tr,
                              ),
                              const SizedBox(width: 20),
                              CustomeRadioButtonAdmin(
                                value: 'Investor',
                                label: '13'.tr,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          backgroundColor: Colors.blueAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          index: controller.index!,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          maxWidth: MediaQuery.of(context).size.width * 0.99,
          items: const [
            Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [Icon(Icons.person, size: 25), Text("Owner")],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  Icon(Icons.person_outline, size: 25),
                  Text("Investor")
                ],
              ),
            ),
          ],
          onTap: (index) {
            controller.onTap(index);
          },
        ),
        body: controller.screens[controller.index!],
      ),
    ));
  }
}
