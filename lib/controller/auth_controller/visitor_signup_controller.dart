import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../function/database_methods.dart';
import '../../view/auth/loginScreen.dart';


class VisitorSignupController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  signup() async {
    if (key.currentState!.validate()) {
      try {
        UserCredential usercurrent =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        ); 
        String idVisitor = FirebaseAuth.instance.currentUser!.uid; 
        Map<String, dynamic> infoVisitor = {
          "email": email.text,
          "password": password.text,
          'image': '',
          "id": idVisitor,
        };
        await DatabaseMethods()
            .addCollection(infoVisitor, idVisitor, 'visitor');
        Get.showSnackbar(const GetSnackBar(
          message: "Visitor account created ",
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
