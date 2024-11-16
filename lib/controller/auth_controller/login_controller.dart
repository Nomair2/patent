import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patents/view/OwnerPatentview/bottomNavBarOwner.dart';
import '../../view/Investorview/bottonNavBarInvestor.dart';
import '../../view/adminView/bottomNavBarAdmin.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  Future Login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found for that email");
      } else if (e.code == "wrong-password") {
        print("wrong password provided for that user");
      }
    } catch (e) {
      print(e);
    }
  }
  Future checkEmail() async {
    await Login().then((value) {
      if (value == null) {
        FirebaseFirestore.instance .collection("owner")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get() .then((val) {
          if (val.exists) {
            if (val.data()!["email"] == email.text &&
                val.data()!["password"] == password.text) {
              Get.offAll(BottomNavBarOwner());
            } else {
              Get.snackbar(
                "Faild Login",
                "Wrong password or email, please try again",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 3),
              );
            }
          } else {
            FirebaseFirestore.instance
                .collection("investor")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((val) {
              if (val.exists) {
                if (val.data()!["email"] == email.text &&
                    val.data()!["password"] == password.text) {
                  Get.offAll(BottomNavBarInvestor());
                } else {
                  Get.snackbar(
                    "Faild Login",
                    "Wrong password or email, please try again",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3),
                  );
                }
              } else {
                FirebaseFirestore.instance
                    .collection("Admin")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((val) {
                  if (val.exists) {
                    if (val.data()!["email"] == email.text &&
                        val.data()!["password"] == password.text) {
                      Get.offAll(BottomNavBarAdmin());
                    } else {
                      Get.snackbar(
                        "Faild Login",
                        "Wrong password or email, please try again",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 3),
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Faild Login",
                      "User Not Found",
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1),
                    );
                  }
                });
              }
            });
          }
        });
      }
    });
  }
}
