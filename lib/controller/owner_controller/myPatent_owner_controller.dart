import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:image_picker/image_picker.dart';
import '../../function/database_methods.dart';
import '../../model/patent_model.dart';

class MypatentOwnerController extends GetxController {
  RxString addImage = ''.obs;
  RxString editImage = ''.obs;
  RxList<PatentModel> myPatents = <PatentModel>[].obs;
  RxList<PatentModel> allPatents = <PatentModel>[].obs;

  TextEditingController addName = TextEditingController();
  TextEditingController adddesc = TextEditingController();
  TextEditingController editName = TextEditingController();
  TextEditingController editdesc = TextEditingController();
  String idOwner = FirebaseAuth.instance.currentUser!.uid;
  String nameOwner = FirebaseAuth.instance.currentUser!.uid;
  RxBool loadingPatents = false.obs;
  RxBool loadingPatentsAll = false.obs;
  RxBool loadingAddPatent = false.obs;
  RxBool loadingUpdatePatent = false.obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  getUserInfo() async {
    await FirebaseFirestore.instance
        .collection("owner")
        .doc(idOwner)
        .snapshots()
        .listen((snapshot) {
      nameOwner = snapshot.data()!["name"];
    });
    update();
  }

  pickImage(bool edit) async {
    if (edit) {
      print("2");
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      editImage.value = image!.path;
    } else {
      print("3");
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      addImage.value = image!.path;
      addImage.refresh();
    }
  }

  addPatent() async {
    loadingAddPatent.value = true;
    loadingAddPatent.refresh();
    String idPatent = randomAlphaNumeric(10);
    String urlImage = await DatabaseMethods()
        .uploadPatentPicture(idPatent, File(addImage.value));
    await DatabaseMethods().addCollection(
      {
        "idPatent": idPatent, 'idOwner': idOwner, 'image': urlImage,
        'name': addName.text, "desc": adddesc.text,
      },
      idPatent, "patent",
    );
    loadingAddPatent.value = false;
    loadingAddPatent.refresh();
    Get.back();
    Get.showSnackbar(const GetSnackBar(
      message: "Patent added", duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,  ));
    update();
  }
  updataPatent(String patentid, String oldImageUrl) async {
    Get.back();
    loadingPatents.value = true;
    loadingAddPatent.refresh();
    String imageUrlToUpload = editImage.value.isNotEmpty
        ? await DatabaseMethods()
            .uploadPatentPicture(patentid, File(editImage.value))
        : oldImageUrl;
    Map<String, dynamic> info = {
      'image': imageUrlToUpload, 'name': editName.text, "desc": editdesc.text,};

    try {
      await DatabaseMethods().updatDoc("patent", patentid, info);
      Get.showSnackbar(const GetSnackBar(
        message: "Modified successfully",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    } catch (e) {
      print("Error updating patent: $e");
      Get.showSnackbar(const GetSnackBar(
        message: "Error updating patent.",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      ));
    } finally {
      loadingPatents.value = false;
      loadingPatents.refresh();
      update();
    }
  }

  deletePatent(id) async {
    loadingPatents.value = true;
    loadingAddPatent.refresh();
    await DatabaseMethods().deleteDoc("patent", id);
    loadingPatents.value = false;
    loadingPatents.refresh();
    Get.showSnackbar(const GetSnackBar(
      message: "Deleted successfully",
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
