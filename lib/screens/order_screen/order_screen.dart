import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:techify/models/order_model/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: kBottomNavigationBarHeight,
        ),
        child: FutureBuilder<List<OrderModel>>(
            future: FirebaseFirestoreHelper.instance.getUserOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(
                    "No Orders Found",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      OrderModel orderModel = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          collapsedShape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: MyColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(
                            color: MyColors.primaryColor,
                            width: 2,
                          )),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Container(
                                  height: context.screenHeight / 6,
                                  width: context.screenWidth / 3,
                                  color: MyColors.primaryColor.withOpacity(0.5),
                                  child: Image.network(
                                    orderModel.products[0].image,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderModel.products[0].name,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    5.height,
                                    orderModel.products.length > 1
                                        ? SizedBox.fromSize()
                                        : Column(
                                            children: [
                                              Text(
                                                'Quantity: ${orderModel.products[0].qty.toString()}',
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                    5.height,
                                    Text(
                                      'Total Price: RS.${orderModel.totalPrice.toString()}',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    5.height,
                                    Text(
                                      'Status: ${orderModel.status}',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    5.height,

                                    orderModel.status == "Pending" ||
                                            orderModel.status == "Delivery"
                                        ? SizedBox(
                                            // height: context.screenHeight / 18,
                                            // width: context.screenWidth / 2.3,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await FirebaseFirestoreHelper
                                                    .instance
                                                    .updateOrderStatus(
                                                        orderModel, "Cancel");
                                                orderModel.status = "Cancel";
                                                setState(() {});
                                              },
                                              child: const Text(
                                                "Cancel Order",
                                                style: TextStyle(
                                                  color: MyColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.fromSize(),
                                    //5.height,
                                    orderModel.status == "Delivery"
                                        ? SizedBox(
                                            // height: context.screenHeight / 18,
                                            // width: context.screenWidth / 2.1,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await FirebaseFirestoreHelper
                                                    .instance
                                                    .updateOrderStatus(
                                                        orderModel,
                                                        "Completed");
                                                // orderModel.status = "Completed";
                                                setState(() {});
                                              },
                                              child: const Text(
                                                "Delivered Order",
                                                style: TextStyle(
                                                  color: MyColors.whiteColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox.fromSize(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          children: orderModel.products.length > 1
                              ? [
                                  const Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(color: MyColors.primaryColor),
                                  ...orderModel.products.map((singleProduct) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                  height:
                                                      context.screenHeight / 8,
                                                  width:
                                                      context.screenWidth / 4,
                                                  color: MyColors.primaryColor
                                                      .withOpacity(0.5),
                                                  child: Image.network(
                                                    singleProduct.image,
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      singleProduct.name,
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    5.height,
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'Quantity: ${singleProduct.qty.toString()}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    5.height,
                                                    Text(
                                                      'Price: RS.${singleProduct.price.toString()}',
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: MyColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ]
                              : [],
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
