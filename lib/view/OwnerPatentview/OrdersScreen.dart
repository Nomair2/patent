import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme.dart';
import 'profileOwnerScreen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.background,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeColor.primary,
          title: ZoomIn(
            delay: const Duration(milliseconds: 150),
            child: Text('29'.tr,
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("orders")
                .where("idOwner",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where("orderStatus", isEqualTo: "pending")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return FadeInLeft(
                          delay: const Duration(milliseconds: 300),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ThemeColor.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection("investor")
                                        .doc(snap[index]["idInvestor"])
                                        .get(),
                                    builder: (context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot1) {
                                      if (snapshot1.hasData) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '38 '.tr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(snapshot1.data!.get("name")),
                                            const SizedBox(height: 16),
                                          ],
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snap[index]["date"]
                                          .toDate()
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      snap[index]["date"]
                                          .toDate()
                                          .toString()
                                          .substring(10, 16),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      child: Text('39'.tr),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("orders")
                                            .doc(snap[index].id)
                                            .update({"orderStatus": "Accept"});
                                        Get.snackbar("Success", "Accepted");
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red)),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("orders")
                                            .doc(snap[index].id)
                                            .update({"orderStatus": "Reject"});
                                        Get.snackbar("Success", "Rejected");
                                      },
                                      child: Text('40'.tr),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
