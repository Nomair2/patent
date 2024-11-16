class OwnerModel {
  String? name;
  String? address;
  String? email;
  String? password;
  String? image;
  String? id;

  OwnerModel({
    this.name,
    this.address,
    this.email,
    this.password,
    this.image,
    this.id,
  });

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      name: map['name'],
      address: map['address'],
      email: map['email'],
      password: map['password'],
      image: map['image'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'password': password,
      'image': image,
      'id': id,
    };
  }
}
