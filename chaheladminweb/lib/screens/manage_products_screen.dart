import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/widgets/product_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Enums/product_edit_enum.dart';
import '../models/product_details_model.dart';
import '../provider/get_all_product_provider.dart';
import '../widgets/custom_popup.dart';
import 'product_edit_screen.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  bool isAllproductsButton = true;
  bool isOrderSortshutter = true;
  
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllProductProvider>(context, listen: false)
          .getFirebaseData(null, isAllproductsButton);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            title: const Text(
              "Manage products",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 5),
                  height: isOrderSortshutter ? null : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                Provider.of<GetAllProductProvider>(context,
                                        listen: false)
                                    .getSearchProduct(value);
                              },
                              onSubmitted: (value) {
                                // Provider.of<OrderProvider>(context,
                                //         listen: false)
                                //     .getFirebaseData(
                                //         null, selectOrderStatus, value);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Search products...",
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: const Icon(
                                  IconlyLight.search,
                                  color: Colors.black,
                                  size: 17,
                                ),
                                isDense: true,
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (searchController.text.isNotEmpty) {
                                        searchController.clear();
                                        setState(() {});
                                        await Provider.of<
                                                    GetAllProductProvider>(
                                                context,
                                                listen: false)
                                            .getFirebaseData(
                                                null, isAllproductsButton);
                                      }
                                    },
                                    icon: const Icon(Icons.close)),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                                contentPadding: const EdgeInsets.all(10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: MaterialButton(
                                height: 45,
                                onPressed: () {
                                  isAllproductsButton = true;
                                  Provider.of<GetAllProductProvider>(context,
                                          listen: false)
                                      .clearData();
                                  Provider.of<GetAllProductProvider>(context,
                                          listen: false)
                                      .getFirebaseData(
                                          null, isAllproductsButton);

                                  setState(() {});
                                },
                                color: isAllproductsButton == true
                                    ? Colors.blue.shade700
                                    : Colors.grey.shade200,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  " All Products ",
                                  style: TextStyle(
                                    color: isAllproductsButton == true
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: MaterialButton(
                                height: 45,
                                minWidth: 110,
                                onPressed: () {
                                  isAllproductsButton = false;
                                  Provider.of<GetAllProductProvider>(context,
                                          listen: false)
                                      .clearData();
                                  Provider.of<GetAllProductProvider>(context,
                                          listen: false)
                                      .getFirebaseData(
                                          null, isAllproductsButton);
                                  setState(() {});
                                },
                                color: isAllproductsButton == false
                                    ? Colors.blue.shade700
                                    : Colors.grey.shade200,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  " Out of stock ",
                                  style: TextStyle(
                                    color: isAllproductsButton == false
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (isOrderSortshutter) {
                    isOrderSortshutter = false;
                  } else {
                    isOrderSortshutter = true;
                  }
                  setState(() {});
                },
                child: Icon(isOrderSortshutter
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: isOrderSortshutter ? 20 : 0),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Product",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800),
                          ),
                          const SizedBox(
                            width: 398,
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(
                            width: 260,
                          ),
                          Text(
                            "Status",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(
                            width: 200,
                          ),
                          Text(
                            "Action",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Provider.of<GetAllProductProvider>(context)
                                .isFirebaseDataLoding ==
                            false
                        ? Provider.of<GetAllProductProvider>(context)
                                .productList
                                .isNotEmpty
                            ? SizedBox(
                                width: 1100,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount:
                                            Provider.of<GetAllProductProvider>(
                                                    context)
                                                .productList
                                                .length,
                                        (context, index) {
                                          return ProductFrame(
                                              productDetails: Provider.of<
                                                          GetAllProductProvider>(
                                                      context)
                                                  .productList[index],
                                              delete: () {
                                                customPoPup(context, "Delete",
                                                    "Delete this product", () {
                                                  FirebaseFirestore.instance
                                                      .collection("products")
                                                      .doc(Provider.of<
                                                                  GetAllProductProvider>(
                                                              context,
                                                              listen: false)
                                                          .productList[index]
                                                          .productID)
                                                      .delete();
                                                  Provider.of<GetAllProductProvider>(
                                                          context,
                                                          listen: false)
                                                      .productList
                                                      .removeAt(index);
                                                  setState(() {});

                                                  /// last 12 ennam ayaalum and circularProgressLOading==true annegil veendum data get cheyyan
                                                  List<ProductDetailsModel>
                                                      catergoryList =
                                                      Provider.of<GetAllProductProvider>(
                                                              context,
                                                              listen: false)
                                                          .productList;
                                                  if (catergoryList.length <=
                                                          8 &&
                                                      Provider.of<GetAllProductProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .circularProgressLOading ==
                                                          true) {
                                                    Provider.of<GetAllProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .getFirebaseData(
                                                            catergoryList
                                                                .last.lastdoc,
                                                            isAllproductsButton);
                                                  }
                                                  //
                                                  if (catergoryList.isEmpty) {
                                                    Provider.of<GetAllProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .getFirebaseData(null,
                                                            isAllproductsButton);
                                                  }
                                                  Navigator.pop(context);
                                                }, "OK");
                                              },
                                              edit: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                    //TODO edit
                                                    return ProductEditScreen(
                                                      productEditEnum:
                                                          ProductEditEnum
                                                              .allproductEditer,
                                                      productDetails: Provider
                                                              .of<GetAllProductProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .productList[index],
                                                    );
                                                  }),
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                        child: Container(
                                      width: 1100,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Provider.of<GetAllProductProvider>(
                                                              context)
                                                          .isFirebaseDataLoding ==
                                                      false &&
                                                  searchController.text.isEmpty
                                              ? Provider.of<GetAllProductProvider>(
                                                              context)
                                                          .circularProgressLOading ==
                                                      true
                                                  ? Tooltip(
                                                      message:
                                                          "Get the next list",
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        height: 45,
                                                        width: 45,
                                                        child: MaterialButton(
                                                          elevation: 3,
                                                          color: Colors.white,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          200))),
                                                          onPressed: () {
                                                            if (Provider.of<GetAllProductProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isNextListDataLoding ==
                                                                false) {
                                                              Provider.of<GetAllProductProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getFirebaseData(
                                                                      Provider.of<GetAllProductProvider>(
                                                                              context,
                                                                              listen: false)
                                                                          .productList
                                                                          .last
                                                                          .lastdoc,
                                                                      isAllproductsButton);
                                                            }
                                                          },
                                                          child: Provider.of<GetAllProductProvider>(
                                                                          context)
                                                                      .isNextListDataLoding ==
                                                                  false
                                                              ? const Icon(
                                                                  CupertinoIcons
                                                                      .add,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 22,
                                                                )
                                                              : const CupertinoActivityIndicator(),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(
                                                      height: 45,
                                                      width: 45,
                                                    )
                                              : Container(),
                                        ],
                                      ),
                                    )),
                                    const SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 300,
                                    width: 1100,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Products is empty...",
                                          style: TextStyle(
                                            fontFamily: "pop",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                width: 1100,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoadingAnimationWidget.waveDots(
                                      color: Colors.grey, //.shade600,
                                      size: 70,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
