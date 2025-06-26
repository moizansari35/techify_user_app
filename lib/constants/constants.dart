import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/sized_box.dart';

void showMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    textColor: MyColors.primaryColor,
    fontSize: 16,
  );
}

void successMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    backgroundColor: MyColors.blackColor,
    textColor: MyColors.greenColor,
    fontSize: 16,
  );
}

void errorMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    backgroundColor: MyColors.blackColor,
    textColor: MyColors.errorColor,
    fontSize: 16,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: MyColors.primaryColor,
            ),
            18.height,
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading..."),
            )
          ],
        ),
      );
    }),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already in use. Go to Login Page.";
    case "account-exists-with-different-credential":
      return "Email already in use. Go to Login Page.";
    case "error_email_already_in_use":
      return "Email already in use. Go to Login Page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No User Found with this email";
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "user disabled";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account";
    case "Operation-not-allowed":
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account";
    case "ERROR_INVALID_EMAIL":
    case "invalid-emal":
      return "Email address is invalid";
    default:
      return "Login failed. Please try again !";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All Fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is Empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone Number is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}
