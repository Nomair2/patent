import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../function/database_methods.dart';
import '../../view/auth/loginScreen.dart';

class InvestorSignupController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxString gender = 'Male'.obs;

  signup() async {
    if (key.currentState!.validate()) {
      try {
        UserCredential usercurrent =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String idInvestor = FirebaseAuth.instance.currentUser!.uid;
        Map<String, dynamic> infoInvestor = {
          "name": name.text,
          "address": address.text,
          "email": email.text,
          "job": job.text,
          "password": password.text,
          'image': '',
          "id": idInvestor,
        };
        await DatabaseMethods()
            .addCollection(infoInvestor, idInvestor, 'investor');
        Get.showSnackbar(const GetSnackBar(
          message: "Investor account created ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ));
        Get.off(LoginScreen());
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
  }
}
