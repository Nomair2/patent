import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../function/database_methods.dart';
import '../../view/adminView/manageInvestorAccounts.dart';
import '../../view/adminView/manageOwnerAccounts.dart';
class AdminController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? account;
  List<Widget> screens = [
    const ManageOwnerAccounts(),
    const ManageInvestorAccounts(),
  ];
  int? index = 0;

  onChanged (String? value) {
  account = value!;
update();
  }

  onTap(i) {
    index = i;
    update();
  }

  addUser()async{
    if (key.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String iduser = FirebaseAuth.instance.currentUser!.uid;
        Map<String, dynamic> infouser = {
          "name": name.text,
          "address": address.text,
          "email": email.text,
          "password": password.text,
          'image': '',
          "id": iduser,
        };
        await DatabaseMethods()
            .addCollection(infouser, iduser, account=="Owner"?"owner":"investor");
        Get.back();
        Get.showSnackbar(const GetSnackBar(
          message: "user account created ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ),);
      } on FirebaseAuthException catch (e) {
        print("2");
        print(e.code);
        if (e.code == 'weak-password') {
          Get.showSnackbar(const GetSnackBar(
            message: " Weak Password",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        } else if (e.code == 'email-already-in-use') {
          Get.showSnackbar(const GetSnackBar(
            message: "Account already exists ",
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ));
        }
      }
    }
    update();
  }

  deleteUser(String id, String collection) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).delete();
    Get.snackbar("Success", "The user has been deleted successfully!!");
    update();
  }
}
