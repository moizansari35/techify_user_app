import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/cart_screen/cart_screen.dart';
import 'package:techify/screens/checkout_screen/checkout_screen.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;

  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
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
        actions: [
          IconButton(
            onPressed: () {
              Routes.routesInstance
                  .push(widget: const CartScreen(), context: context);
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: MyColors.blackColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.network(
                  widget.singleProduct.image,
                  height: context.screenHeight / 100 * 40,
                  width: context.screenWidth * 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !widget.singleProduct.isFavourite;
                        });
                        if (widget.singleProduct.isFavourite == true) {
                          appProvider.addFavouriteProduct(widget.singleProduct);
                        } else {
                          appProvider
                              .removeFavouriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavouriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ],
                ),
                Text(
                  widget.singleProduct.description,
                ),
                12.height,
                Row(
                  children: [
                    CupertinoButton(
                        onPressed: () {
                          setState(() {
                            if (qty >= 1) {
                              qty--;
                            }
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: const CircleAvatar(
                          backgroundColor: MyColors.primaryColor,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: MyColors.whiteColor,
                          ),
                        )),
                    10.width,
                    Text(
                      qty.toString(),
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.width,
                    CupertinoButton(
                        onPressed: () {
                          setState(() {
                            qty++;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: const CircleAvatar(
                          backgroundColor: MyColors.primaryColor,
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: MyColors.whiteColor,
                          ),
                        )),
                  ],
                ),
                5.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        appProvider.addCartProduct(productModel);
                        showMessage("Added to Cart");
                      },
                      child: const Text(
                        "ADD TO CART",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () {
                          ProductModel productModel =
                              widget.singleProduct.copyWith(qty: qty);
                          Routes.routesInstance.push(
                              widget: CheckoutScreen(
                                singleProduct: productModel,
                              ),
                              context: context);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          textStyle: const TextStyle(
                            color: MyColors.primaryColor,
                          ),
                          foregroundColor: MyColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "BUY",
                          style: TextStyle(
                            color: MyColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
