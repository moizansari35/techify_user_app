import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/routes/routes.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:techify/models/category_model/category_model.dart';
import 'package:techify/models/prodcut_model/product_model.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/screens/category_screen/category_screen.dart';
import 'package:techify/screens/product_details/product_details.dart';
import 'package:techify/widgets/titles/top_titles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirbase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController searchController = TextEditingController();
  List<ProductModel> searchProductList = [];
  void searchProducts(String value) {
    searchProductList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopTitles(title: "Techify", subtitle: ""),
                        TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            searchProducts(value);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            hintText: "Search......",
                          ),
                        ),
                        24.height,
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Categories are not found"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: categoriesList
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Routes.routesInstance.push(
                                              widget: CategoryScreen(
                                                  categoryModel: e),
                                              context: context);
                                        },
                                        child: Card(
                                          color: MyColors.backgroundColor,
                                          elevation: 13.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: SizedBox(
                                            height: context.screenHeight * 0.1,
                                            width: context.screenWidth * 0.2,
                                            child: Image.network(e.image),
                                          ),
                                          
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                  12.height,
                  isSearching()
                      ? const Padding(
                          padding: EdgeInsets.only(
                            top: 12.0,
                            left: 12,
                          ),
                          child: Text(
                            "Search Products",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(
                            top: 12.0,
                            left: 12,
                          ),
                          child: Text(
                            "Best Products",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  12.height,
                  searchController.text.isNotEmpty && searchProductList.isEmpty
                      ? const Center(
                          child: Text(
                          "No Data Found",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                      : searchProductList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: searchProductList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 0.8,
                                          crossAxisCount: 2),
                                  itemBuilder: (ctx, index) {
                                    ProductModel singleProduct =
                                        searchProductList[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          12.height,
                                          Image.network(singleProduct.image,
                                              height:
                                                  context.screenHeight * 0.1,
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
                                            height:
                                                context.screenHeight / 100 * 5,
                                            width:
                                                context.screenWidth / 100 * 30,
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
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Best Products are not found",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GridView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 50),
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
                                            color: MyColors.primaryColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              12.height,
                                              Image.network(singleProduct.image,
                                                  height: context.screenHeight *
                                                      0.1,
                                                  width: context.screenWidth *
                                                      0.3),
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
                                                    singleProduct.price
                                                        .toString(),
                                                    style: const TextStyle(
                                                      // fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              12.height,
                                              SizedBox(
                                                height: context.screenHeight /
                                                    100 *
                                                    5,
                                                width: context.screenWidth /
                                                    100 *
                                                    30,
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

  bool isSearching() {
    if (searchController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  // bool isSearched() {
  //   if (searchController.text.isNotEmpty && searchProductList.isEmpty) {
  //     return true;
  //   } else if (searchController.text.isEmpty && searchProductList.isNotEmpty) {
  //     return false;
  //   } else if (searchProductList.isNotEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
