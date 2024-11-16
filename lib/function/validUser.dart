import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> ValidUser(email, collection) async {
  bool inCollection = false;
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();
  List data = querySnapshot.docs;
  for (var item in data) {
    if (item["email"] == email) {
      inCollection = true;
      break;
    }
  }
  return inCollection;
}

Future<bool> ServiceAvailable(idUser, nameService) async {
  bool inCollection = false;

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("service").get();

  List data = querySnapshot.docs;

  for (var item in data) {
    if (item['name'] == nameService) {
      inCollection = true;
      break;
    }
  }

  return inCollection;
}
