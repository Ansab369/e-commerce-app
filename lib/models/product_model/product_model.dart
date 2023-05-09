// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String image;
  String id;
  bool isFavorite;
  String name;
  String price;
  String discription;
  String status;
  ProductModel({
    required this.image,
    required this.id,
    required this.isFavorite,
    required this.name,
    required this.price,
    required this.discription,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'id': id,
      'isFavorite': isFavorite,
      'name': name,
      'price': price,
      'discription': discription,
      'status': status,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      image: map['image'] as String,
      id: map['id'] as String,
      isFavorite: map['isFavorite'] as bool,
      name: map['name'] as String,
      price: map['price'] as String,
      discription: map['discription'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ProductModel.fromJson(String source) =>
  //     ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
