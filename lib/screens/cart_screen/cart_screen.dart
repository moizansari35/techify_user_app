import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/cart_item_checkout_screen/cart_item_checkout_screen.dart';
import 'package:techify/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:techify/widgets/buttons/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      bottomNavigationBar: appProvider.getCartProductList.isEmpty
          ? const Text("No Cart Item to Checkout")
          : SizedBox(
              height: context.screenHeight / 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'RS.${appProvider.totalPrice().toString()}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    5.height,
                    MyPrimaryButton(
                        onPressed: () {
                          appProvider.clearBuyProductList();
                          appProvider.addBuyCartProductList();
                          appProvider.clearCartList();
                          Routes.routesInstance.push(
                              widget: const CartItemCheckoutScreen(),
                              context: context);
                        },
                        title: "Checkout")
                  ],
                ),
              ),
            ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}
