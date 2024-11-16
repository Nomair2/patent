import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patents/view/OwnerPatentview/profileOwnerScreen.dart';
import '../../common/PatentTile.dart';
import '../../common/customTextField.dart';
import '../../common/detailPatentScreen.dart';
import '../../controller/owner_controller/myPatent_owner_controller.dart';
import '../../function/validinput.dart';
import '../../theme.dart';

class MyPatentsScreen extends StatefulWidget {
  const MyPatentsScreen({super.key});

  @override
  State<MyPatentsScreen> createState() => _MyPatentsScreenState();
}

class _MyPatentsScreenState extends State<MyPatentsScreen> {
  MypatentOwnerController controller = Get.put(MypatentOwnerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ThemeColor.background,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ThemeColor.primary,
            title: ZoomIn(
              delay: const Duration(milliseconds: 150),
              child: Text('36'.tr,
                  style: TextStyle(color: ThemeColor.white, fontSize: 23)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ZoomIn(
                    child: IconButton(
                        onPressed: () {
                          Get.to(const ProfileOwnerscreen());
                        },
                        icon: Icon(
                          Icons.settings,
                          color: ThemeColor.white,
                        ))),
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
              _showAddPatent(context);
            },
            child: const Icon(Icons.add),
          ),
          body: GetBuilder<MypatentOwnerController>(
            builder: (controller) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("patent")
                        .where("idOwner",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            return FadeInLeft(
                              delay: const Duration(milliseconds: 300),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      extentRatio: 0.5,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            controller
                                                .deletePatent(snap[index].id);
                                          },
                                          icon: Icons.delete,
                                          backgroundColor: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          spacing: 2,
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            _showEditProfileDialog(
                                                context,
                                                snap[index].id,
                                                snap[index]["image"],
                                                snap[index]["name"],
                                                snap[index]["desc"]);
                                          },
                                          icon: Icons.mode_edit_outline_rounded,
                                          backgroundColor: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          spacing: 2,
                                        ),
                                      ]),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(ItemDetailScreen(
                                        edit: true,
                                        image: snap[index]["image"],
                                        itemDescription: snap[index]["desc"],
                                        itemName: snap[index]["name"],
                                        itemOwner: controller.nameOwner,
                                      ));
                                    },
                                    child: PatentTile(
                                      imagePath: snap[index]["image"],
                                      description: snap[index]["desc"],
                                      patentName: snap[index]["name"],
                                      owner: controller.nameOwner,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
          )),
    );
  }

  void _showAddPatent(BuildContext context) async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFieldWithoutIcon(
                    onIconPressed: () {},
                    controller: controller.addName,
                    title: "31".tr,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFieldWithoutIcon(
                    onIconPressed: () {},
                    title: "37".tr,
                    valide: validInput("desc", 1, "owner", ""),
                    controller: controller.adddesc,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.pickImage(false);
                          },
                          child: Container(
                              height: height * 0.15,
                              width: width * 0.3,
                              color: Colors.white,
                              child: controller.addImage.value.isEmpty == true
                                  ? const Center(
                                      child: Icon(Icons.add_a_photo_outlined),
                                    )
                                  : Image(
                                      fit: BoxFit.fill,
                                      image: FileImage(
                                          File(controller.addImage.value)),
                                    )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
                    controller.addPatent();
                    Get.back();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext contex, String id, String image,
      String name, String desc) async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    controller.editName.text = name;
    controller.editdesc.text = desc;
    controller.editImage.value = '';

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
                  controller: controller.editName,
                  title: "Invention Name",
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                CustomTextFieldWithoutIcon(
                  onIconPressed: () {},
                  title: "Inventio Description",
                  valide: validInput("desc", 1, "owner", ""),
                  controller: controller.editdesc,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.pickImage(true);
                        },
                        child: Container(
                            height: height * 0.15,
                            width: width * 0.3,
                            color: Colors.white,
                            child: controller.editImage.value.isEmpty == true
                                ? Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(image),
                                  )
                                : Image(
                                    fit: BoxFit.fill,
                                    image: FileImage(
                                        File(controller.editImage.value)),
                                  )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('cansel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('save'),
                  onPressed: () {
                    controller.updataPatent(id, image);
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
