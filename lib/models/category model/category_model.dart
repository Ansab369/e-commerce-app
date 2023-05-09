// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class CategoryModel {
//   String name;
//   String id;
//   CategoryModel({
//     required this.name,
//     required this.id,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'id': id,
//     };
//   }

//   factory CategoryModel.fromMap(Map<String, dynamic> map) {
//     return CategoryModel(
//       name: map['name'] as String,
//       id: map['id'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CategoryModel.fromJson(String source) =>
//       CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
  });

  String name;

  String id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
