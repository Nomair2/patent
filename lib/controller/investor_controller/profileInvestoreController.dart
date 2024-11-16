import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../function/database_methods.dart';
import '../../view/selectAccountScreen.dart';

class ProfileInvestorController extends GetxController {
  String idInvestor = FirebaseAuth.instance.currentUser!.uid;
  RxBool loadingInvestor = false.obs;
  String? name;
  String? email;
  String? password;
  String? job;
  String? address;

  TextEditingController nameC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  @override
  void onInit() {
    getInvestor();
    super.onInit();
  }

  Future<void> getInvestor() async {
    loadingInvestor.value = true;
    final user = await DatabaseMethods().getDoc('investor', idInvestor);
    name = user.get("name");
    email = user.get("email");
    address = user.get("address");
    job = user.get("job");
    password = user.get("password");
    loadingInvestor.value = false;
    update();
  }

  Future<void> updataInvestor() async {
    await DatabaseMethods().updatDoc('investor', idInvestor,
        {'name': nameC.text, 'address': addressC.text, "job": jobC.text});
    Get.back();
    getInvestor(); // Refresh data after update
  }

  Future<void> deleteInvestor() async {
    await DatabaseMethods().deleteDoc('investor', idInvestor);
    await DatabaseMethods().deletAccount();
    Get.offAll(SelecetAccount());
    update();
  }

  Future<void> logout() async {
    await DatabaseMethods().logout();
    Get.offAll(SelecetAccount());
    update();
  }
}
