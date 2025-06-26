import 'package:techify/models/prodcut_model/product_model.dart';

class OrderModel {
  String orderId;
  String userId;
  int totalPrice;
  String paymentMethod;
  String status;
  List<ProductModel> products;

  OrderModel({
    required this.orderId,
    required this.totalPrice,
    required this.paymentMethod,
    required this.status,
    required this.products,
    required this.userId,
  });

  // Factory method to create a OrderModel object from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderId: json['orderId'],
      userId: json['userId'],
      totalPrice: json['TotalPrice'],
      paymentMethod: json['PaymentMethod'],
      status: json['status'],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
    );
  }
}
