import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/custom_bottom_nav_bar/custom_bottom_nav_bar.dart';
import 'package:techify/widgets/buttons/primary_button.dart';

class CartItemCheckoutScreen extends StatefulWidget {
  const CartItemCheckoutScreen({
    super.key,
  });

  @override
  State<CartItemCheckoutScreen> createState() => _CartItemCheckoutScreenState();
}

class _CartItemCheckoutScreenState extends State<CartItemCheckoutScreen> {
  int groupValue = 0;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
          "Check Out",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            20.height,
            Container(
              height: context.screenHeight / 10,
              width: context.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.primaryColor, width: 3),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      return (isSelected)
                          ? MyColors.primaryColor
                          : MyColors.blackColor;
                    }),
                  ),
                  const Icon(
                    Icons.money,
                  ),
                  12.width,
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            10.height,
            Container(
              height: context.screenHeight / 10,
              width: context.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.primaryColor, width: 3),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      return (isSelected)
                          ? MyColors.primaryColor
                          : MyColors.whiteColor;
                    }),
                  ),
                  const Icon(
                    Icons.credit_card,
                  ),
                  12.width,
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            24.height,
            MyPrimaryButton(
              onPressed: () async {
                bool value = await FirebaseFirestoreHelper.instance
                    .updateOrderedProductFirebase(
                  appProvider.getBuyProductList,
                  context,
                  groupValue == 1 ? "Cash on Delivery" : "Paid",
                );
                if (value) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Routes.routesInstance.push(
                        // ignore: use_build_context_synchronously
                        widget: const CustomBottomNavBar(),
                        // ignore: use_build_context_synchronously
                        context: context);
                  });
                }
              },
              title: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
