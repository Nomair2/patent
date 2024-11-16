import 'package:flutter/foundation.dart';

class PatentModel {
  String idPatent;
  String idOwner;
  String nameOwner;
  String image;
  String name;
  String desc;

  PatentModel({
    required this.idPatent,
    required this.idOwner,
    required this.nameOwner,
    required this.image,
    required this.name,
    required this.desc,
  });

  // Optional: Method to create an instance from a map
  factory PatentModel.fromJson(Map<String, dynamic> json) {
    return PatentModel(
      idPatent: json['idPatent'] as String,
      idOwner: json['idOwner'] as String,
      nameOwner: json['nameOwner'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String,
    );
  }

  // Optional: Method to convert to a map
  Map<String, dynamic> toMap() {
    return {
      'idPatent': idPatent,
      'idOwner': idOwner,
      'nameOwner': nameOwner,
      'image': image,
      'name': name,
      'desc': desc,
    };
  }
}
