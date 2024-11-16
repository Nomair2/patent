import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/PatentTile.dart';
import '../../common/detailPatentScreenVisitor.dart';
import '../../locale/localeController.dart';
import '../../theme.dart';

class AllPatentScreenVisitor extends StatefulWidget {
  const AllPatentScreenVisitor({super.key});

  @override
  State<AllPatentScreenVisitor> createState() => _AllPatentScreenVisitorState();
}

class _AllPatentScreenVisitorState extends State<AllPatentScreenVisitor> {
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  bool haveProductSearched = false;

  Future<String?> fetchOwnerName(String patentId) async {
    try {
      DocumentSnapshot patentSnapshot = await FirebaseFirestore.instance
          .collection("patent")
          .doc(patentId)
          .get();
      String ownerId = patentSnapshot.get("idOwner");
      DocumentSnapshot ownerSnapshot = await FirebaseFirestore.instance
          .collection("owner")
          .doc(ownerId)
          .get();
      return ownerSnapshot.get("name");
    } catch (e) {
      print("Error fetching owner name: $e");
      return null;
    }
  }

  Future<void> initiateSearchByName(String searchField) async {
    String searchLower = searchField.toLowerCase();
    searchSnapshot = await FirebaseFirestore.instance
        .collection("patent")
        .where("name", isGreaterThanOrEqualTo: searchLower)
        .where("name", isLessThanOrEqualTo: '$searchLower\uf8ff')
        .get();
    setState(() {
      haveProductSearched =
          true; // Update state to indicate that search has been done
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MyLocalController);
    MyLocalController lang = Get.find();
    return Scaffold(
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ZoomIn(
                child: IconButton(
                    onPressed: () {
                      String currentLang = Get.locale!.languageCode;
                      String newLang;
                      currentLang == 'ar'
                          ? {newLang = 'en-US', currentLang = "en"}
                          : {newLang = 'ar-SA', currentLang = "ar"};
                      lang.changeLanguage(currentLang);
                    },
                    icon: Icon(
                      Icons.language,
                      color: ThemeColor.white,
                    ))),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(children: [
          TextField(
            controller: searchController,
            style: TextStyle(color: ThemeColor.black),
            decoration: InputDecoration(
              hintText: '25'.tr,
              hintStyle: TextStyle(color: ThemeColor.black.withOpacity(0.5)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(25),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                initiateSearchByName(value);
              } else {
                setState(() {
                  haveProductSearched = false; // Reset search state
                });
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("patent").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = haveProductSearched
                        ? searchSnapshot?.docs
                        : snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap?.length ?? 0,
                      itemBuilder: (context, index) {
                        return FutureBuilder<String?>(
                          future: fetchOwnerName(snap![index].id),
                          builder: (context, ownerSnapshot) {
                            if (ownerSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child:
                                    CircularProgressIndicator(), // Show loading indicator
                              );
                            }

                            String? ownerName = ownerSnapshot.data;
                            return FadeInLeft(
                              delay: const Duration(milliseconds: 300),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ItemDetailScreenVisitor(
                                    itemId: snap[index].id,
                                    itemOwnerID: snap[index]["idOwner"],
                                    itemImages: snap[index]["image"],
                                    itemDescription: snap[index]["desc"],
                                    itemName: snap[index]["name"],
                                    itemOwner: ownerName ??
                                        "Unknown Owner", // Fallback
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: PatentTile(
                                    imagePath: snap[index]["image"],
                                    description: snap[index]["desc"],
                                    patentName: snap[index]["name"],
                                    owner: ownerName ??
                                        "Unknown Owner", // Fallback
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
