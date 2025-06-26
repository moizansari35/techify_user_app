import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/constants.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/provider/app_provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key, required this.singleProduct});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
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
                        Text(
                          widget.singleProduct.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AppProvider appProvider = Provider.of<AppProvider>(
                              context,
                              listen: false,
                            );
                            appProvider
                                .removeFavouriteProduct(widget.singleProduct);
                            showMessage("Removed from Wishlist");
                          },
                          child: const Text(
                            "Remove from Wishlist",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RS.${widget.singleProduct.price.toString()}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
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
