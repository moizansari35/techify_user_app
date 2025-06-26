import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/about_screen/about_screen.dart';
import 'package:techify/screens/change_password/change_password.dart';
import 'package:techify/screens/edit_profile/edit_profile.dart';
import 'package:techify/screens/favourite_screen/favourite_screen.dart';
import 'package:techify/widgets/buttons/primary_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: context.screenWidth,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.4),
                ),
                child: Column(
                  children: [
                    10.height,
                    appProvider.getUserInfo.image == null
                        ? const Icon(
                            Icons.person_outline,
                            size: 120,
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(appProvider.getUserInfo.image!),
                          ),
                    Text(
                      appProvider.getUserInfo.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      appProvider.getUserInfo.email,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: context.screenWidth / 2,
                        child: MyPrimaryButton(
                            onPressed: () {
                              Routes.routesInstance.push(
                                  widget: const EditProfile(),
                                  context: context);
                            },
                            title: "Edit Profile"),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.shopping_bag_outlined,
                        color: MyColors.blackColor,
                      ),
                      title: const Text(
                        "Your Orders",
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.routesInstance.push(
                            widget: const FavouriteScreen(), context: context);
                      },
                      leading: const Icon(
                        Icons.favorite_border,
                        color: MyColors.blackColor,
                      ),
                      title: const Text(
                        "Favourites",
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.routesInstance.push(
                            widget: const AboutScreen(), context: context);
                      },
                      leading: const Icon(
                        Icons.info_outline,
                        color: MyColors.blackColor,
                      ),
                      title: const Text(
                        "About us",
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Routes.routesInstance.push(
                            widget: const ChangePassword(), context: context);
                      },
                      leading: const Icon(
                        Icons.change_circle_outlined,
                        color: MyColors.blackColor,
                      ),
                      title: const Text(
                        "Change Passowrd",
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        FirebaseAuthHelper.instance.logOut(context);
                      },
                      leading: const Icon(
                        Icons.logout_outlined,
                        color: MyColors.blackColor,
                      ),
                      title: const Text(
                        "Log out",
                      ),
                    ),
                    10.height,
                    const Text(
                      "Version 1.0.0",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
