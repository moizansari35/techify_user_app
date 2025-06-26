import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:techify/widgets/buttons/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.blackColor,
          ),
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: [
          TextFormField(
            controller: newPasswordController,
            cursorColor: MyColors.primaryColor,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "New Password",
              prefixIcon: const Icon(
                Icons.password_outlined,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                icon: isShowPassword
                    ? const Icon(
                        Icons.visibility_off,
                      )
                    : const Icon(
                        Icons.visibility,
                      ),
              ),
            ),
          ),
          15.height,
          TextFormField(
            controller: confirmPasswordController,
            cursorColor: MyColors.primaryColor,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Confrim Password",
              prefixIcon: const Icon(
                Icons.password_outlined,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                icon: isShowPassword
                    ? const Icon(
                        Icons.visibility_off,
                      )
                    : const Icon(
                        Icons.visibility,
                      ),
              ),
            ),
          ),
          40.height,
          MyPrimaryButton(
            onPressed: () async {
              if (newPasswordController.text.isEmpty &&
                  confirmPasswordController.text.isEmpty) {
                errorMessage('Both fields are Empty');
              } else if (newPasswordController.text.isEmpty) {
                errorMessage('New Password is Empty');
              } else if (confirmPasswordController.text.isEmpty) {
                errorMessage('Confirm Password is Empty');
              } else if (confirmPasswordController.text ==
                  newPasswordController.text) {
                FirebaseAuthHelper.instance
                    .changePasssowrd(newPasswordController.text, context);
              } else {
                errorMessage('Confirm Password is not Match');
              }
            },
            title: "Update",
          )
        ],
      ),
    );
  }
}
