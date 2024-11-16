import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme.dart';
import 'profileInvestorScreen.dart';

class OrdersScreenInvestor extends StatefulWidget {
  const OrdersScreenInvestor({super.key});

  @override
  State<OrdersScreenInvestor> createState() => _OrdersScreenInvestorState();
}

class _OrdersScreenInvestorState extends State<OrdersScreenInvestor> {
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
                        Get.to(const Profileinvestorscreen());
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
                .where("idInvestor",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('30 '.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(snap[index]["ownerName"]),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('31 '.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(snap[index]["inventionName"]),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            snap[index]["date"]
                                                .toDate()
                                                .toString()
                                                .substring(0, 10),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            snap[index]["date"]
                                                .toDate()
                                                .toString()
                                                .substring(10, 16),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      snap[index]["orderStatus"] == "pending"
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.red
                                                              .withOpacity(
                                                                  0.6))),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("orders")
                                                    .doc(snap[index].id)
                                                    .delete();
                                                Get.snackbar("success",
                                                    "Your order has been deleted successfully");
                                              },
                                              child: Text(
                                                'Cansel',
                                                style: TextStyle(
                                                    color: ThemeColor.black),
                                              ),
                                            )
                                          : Text(
                                              snap[index]["orderStatus"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                    ],
                                  ),
                                ],
                              ),
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
