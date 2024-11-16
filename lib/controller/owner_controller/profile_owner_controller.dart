import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../function/database_methods.dart';
import '../../model/owner_model.dart';
import '../../view/selectAccountScreen.dart';


class ProfileOwnerController extends GetxController {
  String idOwner = FirebaseAuth.instance.currentUser!.uid;
  Rx<OwnerModel> owner = OwnerModel().obs;
  RxBool loadingOwner = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void onInit() {
    getOwner();
    super.onInit();
  }


  getOwner() async {
    loadingOwner.value = true;
    final user = await DatabaseMethods().getDoc('owner', idOwner);
    owner.value = OwnerModel.fromMap(user.data() as Map<String, dynamic>);
    owner.refresh();
    loadingOwner.value = false;
  }

  updataOwner() async {
    await DatabaseMethods().updatDoc('owner', idOwner, {
      'name': name.text,
      'address': address.text,
    });
    Get.back();
    getOwner();
  }

  deleteOwner() async {
    await DatabaseMethods().deleteDoc('owner', idOwner);
    await DatabaseMethods().deletAccount();
    Get.offAll(SelecetAccount());
  }

  logout() async {
    await DatabaseMethods().logout();
    Get.offAll(SelecetAccount());
  }
}
