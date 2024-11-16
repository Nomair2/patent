import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patents/function/database_methods.dart';

import '../../view/auth/loginScreen.dart';


class OwnerSignupController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
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
        String idOwner = FirebaseAuth.instance.currentUser!.uid;
        Map<String, dynamic> infoOwner = {
          "name": name.text,
          "address": address.text,
          "email": email.text,
          "password": password.text,
          'image': '',
          "id": idOwner,
        };
        await DatabaseMethods().addCollection(infoOwner, idOwner, 'owner');
        Get.showSnackbar(const GetSnackBar(
          message: "Owner account created ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        ));
        Get.off(LoginScreen());
      } on FirebaseAuthException catch (e) { 
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
