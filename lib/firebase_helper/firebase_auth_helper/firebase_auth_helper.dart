// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/models/user_model/user_model.dart';
import 'package:techify/screens/auth_ui/login/login_screen.dart';
import 'package:techify/screens/home/welcome_screen.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();
      errorMessage(error.code.toString());
    }
    {
      return false;
    }
  }

  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        image: null,
      );
      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      errorMessage(error.code.toString());
    }
    {
      return false;
    }
  }

  void logOut(BuildContext context) async {
    try {
      await _auth.signOut();
      successMessage("Logout");
      Routes.routesInstance.pushandRemoveUntil(const WelcomeScreen(), context);
    } catch (e) {
      errorMessage(e.toString());
    }
  }

  Future<bool> changePasssowrd(String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      FirebaseAuth.instance.currentUser!.updatePassword(password);

      Navigator.of(context, rootNavigator: true).pop();
      Routes.routesInstance.pushandRemoveUntil(const LoginScreen(), context);
      successMessage(
          'Password Changed Successfully\nNeed to Sign in again with New Password');

      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      errorMessage(error.code.toString());
    }
    {
      return false;
    }
  }
}
