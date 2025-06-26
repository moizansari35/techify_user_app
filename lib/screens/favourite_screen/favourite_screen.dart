import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/favourite_screen/widgets/single_favourite_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

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
          "My Wishlist",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? const Center(
              child: Text(
                "No Favourite Item",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getFavouriteProductList.length,
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              },
            ),
    );
  }
}
