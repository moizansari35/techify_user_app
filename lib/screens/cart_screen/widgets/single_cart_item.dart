import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 0;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: MyColors.primaryColor,
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: context.screenHeight / 5,
                color: MyColors.primaryColor.withOpacity(0.5),
                child: Image.network(
                  widget.singleProduct.image,
                )),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: context.screenHeight / 5,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FittedBox(
                          child: Text(
                            widget.singleProduct.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  if (qty > 1) {
                                    qty--;
                                  }
                                });
                                appProvider.updateQty(
                                    widget.singleProduct, qty);
                              },
                              padding: EdgeInsets.zero,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                backgroundColor: MyColors.primaryColor,
                                child: Icon(
                                  Icons.remove,
                                  color: MyColors.whiteColor,
                                ),
                              ),
                            ),
                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  qty++;
                                });
                                appProvider.updateQty(
                                    widget.singleProduct, qty);
                              },
                              padding: EdgeInsets.zero,
                              child: const CircleAvatar(
                                maxRadius: 13,
                                backgroundColor: MyColors.primaryColor,
                                child: Icon(
                                  Icons.add,
                                  color: MyColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (!appProvider.getFavouriteProductList
                                .contains(widget.singleProduct)) {
                              appProvider
                                  .addFavouriteProduct(widget.singleProduct);
                              showMessage("Added to Wishlist");
                            } else {
                              appProvider
                                  .removeFavouriteProduct(widget.singleProduct);
                              showMessage("Removed from Wishlist");
                            }
                          },
                          child: Text(
                            appProvider.getFavouriteProductList
                                    .contains(widget.singleProduct)
                                ? "Remove from Wishlist"
                                : "Add to Wishlist",
                            style: const TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: Text(
                            'RS.${widget.singleProduct.price.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            appProvider.removeCartProduct(widget.singleProduct);
                            showMessage("Removed from Cart");
                          },
                          child: const CircleAvatar(
                            backgroundColor: MyColors.primaryColor,
                            maxRadius: 13,
                            child: Icon(
                              Icons.delete,
                              size: 16,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
