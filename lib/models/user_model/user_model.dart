// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.email,
  });

  String name;
  String? image;
  String email;
  String id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
      };

  UserModel copyWith({String? name, image}) {
    return UserModel(
      image: image ?? this.image,
      id: id,
      name: name ?? this.name,
      email: email,
    );
  }
}
