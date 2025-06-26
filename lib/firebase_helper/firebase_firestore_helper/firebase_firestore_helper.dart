// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/models/category_model/category_model.dart';
import 'package:techify/models/order_model/order_model.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> prodcutModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return prodcutModelList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryScreenProducts(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> prodcutModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return prodcutModelList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInfo() async {
    //String docsid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(documentSnapshot.data()!);
  }

  Future<bool> updateOrderedProductFirebase(
    List<ProductModel> productModelList,
    BuildContext context,
    String paymentMethod,
  ) async {
    try {
      showLoaderDialog(context);
      int totalPrice = 0;
      for (var element in productModelList) {
        totalPrice += element.price * element.qty!;
      }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference documentReference = _firebaseFirestore
          .collection("user_orders")
          .doc(uid)
          .collection("orders")
          .doc();

      documentReference.set({
        "products": productModelList.map((e) => e.toJson()),
        "status": "Pending",
        "TotalPrice": totalPrice,
        "PaymentMethod": paymentMethod,
        "orderId": documentReference.id,
        "userId": uid,
      });

      DocumentReference admin =
          _firebaseFirestore.collection("orders").doc(documentReference.id);

      admin.set({
        "products": productModelList.map((e) => e.toJson()),
        "status": "Pending",
        "TotalPrice": totalPrice,
        "PaymentMethod": paymentMethod,
        "orderId":
            admin.id, // or documentReference.id it will be the same docs id //
        "userId": uid,
      });
      successMessage("Order Done Successfully");
      Navigator.of(context, rootNavigator: true).pop();
      return true;
    } catch (e) {
      errorMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }

  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("user_orders")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("orders")
              .get();
      List<OrderModel> orderList =
          querySnapshot.docs.map((e) => OrderModel.fromJson(e.data())).toList();

      return orderList;
    } catch (e) {
      errorMessage(e.toString());
      return [];
    }
  }

  Future<void> updateOrderStatus(
      OrderModel orderModel, String newstatus) async {
    await _firebaseFirestore
        .collection("orders")
        .doc(orderModel.orderId)
        .update({
      "status": newstatus,
    });
    await _firebaseFirestore
        .collection("user_orders")
        .doc(orderModel.userId) // or FirebaseAuth.instance.currentUser!.uid
        .collection("orders")
        .doc(orderModel.orderId)
        .update({
      "status": newstatus,
    });
  }

  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "notificationToken": token,
      });
    }
  }
}
