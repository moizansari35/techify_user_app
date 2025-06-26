import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String? image;
  String name;
  String email;

  UserModel({
    required this.id,
    this.image,
    required this.name,
    required this.email,
  });

  // Factory method to create a UserModel object from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      email: json['email'],
    );
  }

  // Method to convert a UserModel object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'email': email,
    };
  }

  UserModel copyWith({
    String? name,
    image,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email,
      image: image ?? this.image,
    );
  }
}
