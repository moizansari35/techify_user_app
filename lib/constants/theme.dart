import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';

ThemeData themeData = ThemeData(
  primaryColor: MyColors.primaryColor,
  scaffoldBackgroundColor: MyColors.backgroundColor,
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    prefixIconColor: MyColors.greyColor,
    suffixIconColor: MyColors.greyColor,
    focusColor: MyColors.primaryColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.whiteColor,
  ),
  iconTheme: const IconThemeData(color: MyColors.blackColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColors.primaryColor,
      disabledBackgroundColor: MyColors.greyColor,
      textStyle: const TextStyle(
        fontSize: 18.0,
        color: MyColors.whiteColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(
        color: MyColors.primaryColor,
      ),
      foregroundColor: MyColors.primaryColor,
      side: const BorderSide(
        color: MyColors.primaryColor,
        width: 1.7,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    ),
  ),
);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
    color: MyColors.greyColor,
  ),
);
