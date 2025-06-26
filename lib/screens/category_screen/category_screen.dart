import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:techify/models/category_model/category_model.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/screens/product_details/product_details.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryScreen({super.key, required this.categoryModel});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList =
        await FirebaseFirestoreHelper.instance.getCategoryScreenProducts(
      widget.categoryModel.id,
    );
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      100.width,
                      Text(
                        widget.categoryModel.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Best Products are not found"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        MyColors.primaryColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      12.height,
                                      Image.network(singleProduct.image,
                                          height: context.screenHeight * 0.1,
                                          width: context.screenWidth * 0.3),
                                      12.height,
                                      Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "PKR: ",
                                          ),
                                          Text(
                                            singleProduct.price.toString(),
                                            style: const TextStyle(
                                              // fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      12.height,
                                      SizedBox(
                                        height: context.screenHeight / 100 * 5,
                                        width: context.screenWidth / 100 * 30,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Routes.routesInstance.push(
                                                widget: ProductDetails(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          child: const Text(
                                            "Buy",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  12.height,
                ],
              ),
            ),
    );
  }
}
