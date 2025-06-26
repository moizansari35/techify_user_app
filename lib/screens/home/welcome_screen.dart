import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techify/constants/assets_path.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/screens/auth_ui/login/login_screen.dart';
import 'package:techify/screens/auth_ui/login/signup/signup_screen.dart';
import 'package:techify/widgets/buttons/primary_button.dart';
import 'package:techify/widgets/titles/top_titles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(
              title: "Welcome",
              subtitle: "Buy any Tech Item from Home",
            ),
            Center(
              child: Image.asset(
                AssetsImages.assetsImages.welcome2Image,
                scale: 2,
                alignment: Alignment.center,
              ),
            ),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    AssetsIcons.assetsIcons.fbIcon,
                    scale: 65,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    AssetsIcons.assetsIcons.googleIcon,
                    scale: 20,
                  ),
                ),
              ],
            ),
            20.height,
            MyPrimaryButton(
              title: "Login",
              onPressed: () {
                Routes.routesInstance
                    .push(widget: const LoginScreen(), context: context);
              },
            ),
            10.height,
            MyPrimaryButton(
              title: "Signup",
              onPressed: () {
                Routes.routesInstance
                    .push(widget: const SignupScreen(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
