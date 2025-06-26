// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:techify/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  final List<ProductModel> _cartProductList = [];

  // Cart List Privder
  // add cart function
  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  // remove cart function
  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  // Favourite List Privder
  // add favourtie function

  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  // remove favourtie function
  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  // get user info from firebase function
  UserModel? _userModel;
  UserModel get getUserInfo => _userModel!;

  // UserModel? _userModel;
  // UserModel? get getUserInfo => _userModel;

  void getUserInfoFirbase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInfo();
    notifyListeners();
  }

  // update User Info in firebase function
  void updateUserInfoFirebase(
      BuildContext context, UserModel usermodel, File? image) async {
    _userModel = usermodel;
    if (image == null) {
      showLoaderDialog(context);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      successMessage("Name Updated Successfully");
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(image);
      _userModel = usermodel.copyWith(
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      notifyListeners();
      successMessage("Profile Updated Successfully");
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  // Total Price Provider Functions//
  int totalPrice() {
    int totalPrice = 0;

    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  int totalPriceBuyProductList() {
    int totalPrice = 0;

    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  // Update the Qty of the Cart item for its Price //
  void updateQty(
    ProductModel productmodel,
    int qty,
  ) {
    int index = _cartProductList.indexOf(productmodel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  // add BuyProductList Function //

  final List<ProductModel> _buyProductList = [];

  void addBuyProductList(ProductModel productmodel) {
    _buyProductList.add(productmodel);
    notifyListeners();
  }

  void addBuyCartProductList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCartList() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProductList() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;

  // update User Info in firebase function from Chat GPT
  // void updateUserInfoFirebase(
  //     BuildContext context, UserModel usermodel, File? image) async {
  //   // Show loading dialog
  //   showLoaderDialog(context);

  //   try {
  //     if (image != null) {
  //       // Upload new image and get the URL
  //       String imageUrl =
  //           await FirebaseStorageHelper.instance.uploadUserImage(image);

  //       // Update the user model with the new image URL
  //       usermodel = usermodel.copyWith(image: imageUrl);
  //     }

  //     // Update the Firestore document with the new user model data
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(usermodel.id)
  //         .update(usermodel.toJson());

  //     // Show success message
  //     successMessage(image == null
  //         ? "Name Updated Successfully"
  //         : "Profile Updated Successfully");
  //   } catch (e) {
  //     // Handle any errors here
  //     errorMessage("Error updating user info: $e");
  //   } finally {
  //     // Close the loading dialog and navigate back
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.of(context).pop();
  //     notifyListeners();
  //   }
  // }
}
