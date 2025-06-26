// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:techify/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:techify/widgets/buttons/primary_button.dart';
import 'package:techify/widgets/titles/top_titles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: "Create Account",
                  subtitle: "Welcome Back to My Store"),
              30.height,
              TextFormField(
                controller: nameController,
                cursorColor: MyColors.primaryColor,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
              ),
              10.height,
              TextFormField(
                controller: emailController,
                cursorColor: MyColors.primaryColor,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              10.height,
              TextFormField(
                controller: phoneController,
                cursorColor: MyColors.primaryColor,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                ),
              ),
              10.height,
              TextFormField(
                controller: passwordController,
                cursorColor: MyColors.primaryColor,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Password",
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
                  bool isValidated = signUpValidation(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    passwordController.text,
                  );
                  if (isValidated) {
                    bool isLogin = await FirebaseAuthHelper.instance.signUp(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      context,
                    );
                    if (isLogin) {
                      Routes.routesInstance.pushandRemoveUntil(
                          const CustomBottomNavBar(), context);
                    }
                  }
                },
                title: "Create Account",
              ),
              10.height,
              const Center(
                child: Text(
                  "Already have an account ?",
                ),
              ),
              Center(
                child: CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(color: MyColors.primaryColor, fontSize: 14),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
