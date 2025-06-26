import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String image;
  String name;
  int price;
  String description;
  // String status;
  bool isFavourite;

  int? qty;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    // required this.status,
    required this.isFavourite,
    this.qty,
  });

  // Factory method to create a ProductModel object from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      price: int.parse(json['price'].toString()),
      description: json['description'],
      // status: json['status'],
      isFavourite: false,
      qty: json["qty"],
    );
  }
  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     id: json['id'] ?? '', // Provide default value if null
  //     image: json['image'] ?? '', // Provide default value if null
  //     name: json['name'] ?? '', // Provide default value if null
  //     price: json['price'] != null ? int.parse(json['price'].toString()) : 0,
  //     description: json['description'] ?? '', // Provide default value if null
  //     status: json['status'] ?? '', // Provide default value if null
  //     isFavourite: json['isFavourite'] ?? false,
  //     qty: json["qty"], // Assuming qty can be null
  //   );
  // }

  // Method to convert a ProductModel object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      // 'status': status,
      'isFavourite': isFavourite,
      'qty': qty,
    };
  }

  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        id: id,
        image: image,
        name: name,
        price: price,
        description: description,
        // status: status,
        isFavourite: isFavourite,
        qty: qty ?? this.qty,
      );
}
