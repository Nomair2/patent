import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/PatentTile.dart';
import '../../common/detailPatentScreen.dart';
import '../../controller/owner_controller/myPatent_owner_controller.dart';
import '../../theme.dart';


class AllPatentScreenOwner extends StatefulWidget {
  const AllPatentScreenOwner({super.key});

  @override
  State<AllPatentScreenOwner> createState() => _AllPatentScreenOwnerState();
}

class _AllPatentScreenOwnerState extends State<AllPatentScreenOwner> {
  MypatentOwnerController controller = Get.find<MypatentOwnerController>();

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
            child: Text('24'.tr,
                style: TextStyle(color: ThemeColor.white, fontSize: 23)),
          ),

          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GetBuilder<MypatentOwnerController>(
                builder: (controller) => StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("patent")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            return FadeInLeft(
                              delay: const Duration(milliseconds: 300),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ItemDetailScreen(
                                    image: snap[index]["image"],
                                    itemDescription: snap[index]["desc"],
                                    itemName: snap[index]["name"],
                                    itemOwner: controller.nameOwner,
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: PatentTile(
                                    imagePath: snap[index]["image"],
                                    description: snap[index]["desc"],
                                    patentName: snap[index]["name"],
                                    owner: controller.nameOwner,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }))),
      ),
    );
  }
}
