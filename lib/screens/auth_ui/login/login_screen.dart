// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:techify/screens/auth_ui/login/signup/signup_screen.dart';
import 'package:techify/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:techify/widgets/buttons/primary_button.dart';
import 'package:techify/widgets/titles/top_titles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: "Login", subtitle: "Welcome Back to My Store"),
              40.height,
              TextFormField(
                controller: emailController,
                cursorColor: MyColors.primaryColor,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(
                    Icons.email_outlined,
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
                  bool isValidated = loginValidation(
                      emailController.text, passwordController.text);
                  if (isValidated) {
                    bool isLogin = await FirebaseAuthHelper.instance.login(
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
                title: "Login",
              ),
              20.height,
              const Center(
                child: Text(
                  "Don't have an account ?",
                ),
              ),
              Center(
                child: CupertinoButton(
                    onPressed: () {
                      Routes.routesInstance
                          .push(widget: const SignupScreen(), context: context);
                    },
                    child: const Text(
                      "Create an account",
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
