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
  int? quantity;
  ProductModel({
    required this.image,
    required this.id,
    required this.isFavorite,
    required this.name,
    required this.price,
    required this.discription,
    required this.status,
    this.quantity,
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
      'quantity': quantity
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        discription: json["discription"],
        image: json["image"],
        isFavorite: false,
        quantity: json["quantity"],
        status: json['status'],
        price: json["price"],
      );

  ProductModel copyWith({
    int? quantity,
  }) {
    return ProductModel(
      image: image,
      id: id,
      isFavorite: isFavorite,
      name: name,
      price: price,
      discription: discription,
      status: status,
      quantity: quantity,
    );
  }

  String toJson() => json.encode(toMap());
}
