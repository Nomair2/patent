import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patents/common/primareButton.dart';

class ItemDetailScreenInvest extends StatelessWidget {
  final String itemName;
  final String itemId;
  final String itemOwner;
  final String itemOwnerID;
  final String itemImages;
  final String itemDescription;

  const ItemDetailScreenInvest({
    super.key,
    required this.itemName,
    required this.itemOwner,
    required this.itemImages,
    required this.itemDescription,
    required this.itemOwnerID,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('49'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Name
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '31'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Item Owner

              const SizedBox(height: 16),

              // Images
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.network(
                    itemImages,
                    fit: BoxFit.cover,
                  )),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '30'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    itemOwner,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                '48'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(itemDescription),

              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    height: 40,
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection("orders")
                          .doc()
                          .set({
                        "idOwner": itemOwnerID,
                        "idInvestor": FirebaseAuth.instance.currentUser!.uid,
                        "inventionId": itemId,
                        "ownerName": itemOwner,
                        "inventionName": itemName,
                        "orderStatus": "pending",
                        "date": DateTime.now()
                      });
                      Get.snackbar(
                          "Success", "Your order has been sent successfully");
                    },
                    text: "53".tr,
                    width: 120,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
