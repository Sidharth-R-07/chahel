import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/models/sub_category_model.dart';

import 'package:ecommerceadminweb/provider/get_product_provider.dart';
import 'package:ecommerceadminweb/screens/product_edit_screen.dart';
import 'package:ecommerceadminweb/widgets/product_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../Enums/product_edit_enum.dart';
import '../models/product_details_model.dart';
import '../widgets/custom_popup.dart';

class ProductsDisplayScreen extends StatefulWidget {
  const ProductsDisplayScreen({super.key, required this.subCategory});
  final SubCategoryModel subCategory;
  @override
  State<ProductsDisplayScreen> createState() => _ProductsDisplayScreenState();
}

class _ProductsDisplayScreenState extends State<ProductsDisplayScreen> {
  TextEditingController searchController = TextEditingController();
  bool isOrderSortshutter = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<GetProductProvider>(context, listen: false).clearData();
        Provider.of<GetProductProvider>(context, listen: false)
            .getFirebaseData(widget.subCategory, null);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.subCategory.title!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
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
                                Provider.of<GetProductProvider>(context,
                                        listen: false)
                                    .getSearchProduct(
                                        value, widget.subCategory);
                              },
                              onSubmitted: (value) {
                                // Provider.of<OrderProvider>(context,
                                //         listen: false)
                                //     .getFirebaseData(widget.categorydetails,
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
                                        await Provider.of<GetProductProvider>(
                                                context,
                                                listen: false)
                                            .getFirebaseData(
                                                widget.subCategory, null);
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
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
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
                    child: Provider.of<GetProductProvider>(context)
                                .isFirebaseDataLoding ==
                            false
                        ? Provider.of<GetProductProvider>(context)
                                .productList
                                .isNotEmpty
                            ? SizedBox(
                                width: 1100,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount:
                                            Provider.of<GetProductProvider>(
                                                    context)
                                                .productList
                                                .length,
                                        (context, index) {
                                          return ProductFrame(
                                              productDetails: Provider.of<
                                                          GetProductProvider>(
                                                      context)
                                                  .productList[index],
                                              delete: () {
                                                customPoPup(context, "Delete",
                                                    "Delete this product", () {
                                                  FirebaseFirestore.instance
                                                      .collection("products")
                                                      .doc(Provider.of<
                                                                  GetProductProvider>(
                                                              context,
                                                              listen: false)
                                                          .productList[index]
                                                          .productID)
                                                      .delete();
                                                  Provider.of<GetProductProvider>(
                                                          context,
                                                          listen: false)
                                                      .productList
                                                      .removeAt(index);
                                                  setState(() {});

                                                  /// last 12 ennam ayaalum and circularProgressLOading==true annegil veendum data get cheyyan
                                                  List<ProductDetailsModel>
                                                      catergoryList =
                                                      Provider.of<GetProductProvider>(
                                                              context,
                                                              listen: false)
                                                          .productList;
                                                  if (catergoryList.length <=
                                                          8 &&
                                                      Provider.of<GetProductProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .ircularProgressLOading ==
                                                          true) {
                                                    Provider.of<GetProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .getFirebaseData(
                                                      widget.subCategory,
                                                      catergoryList
                                                          .last.lastdoc,
                                                    );
                                                  }
                                                  //
                                                  if (catergoryList.isEmpty) {
                                                    Provider.of<GetProductProvider>(
                                                            context,
                                                            listen: false)
                                                        .getFirebaseData(
                                                      widget.subCategory,
                                                      null,
                                                    );
                                                  }
                                                  Navigator.pop(context);
                                                }, "OK");
                                              },
                                              edit: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return ProductEditScreen(
                                                          productEditEnum:
                                                              ProductEditEnum
                                                                  .productEditer,
                                                          productDetails: Provider.of<
                                                                      GetProductProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .productList[index]);
                                                    },
                                                  ),
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
                                          Provider.of<GetProductProvider>(
                                                              context)
                                                          .isFirebaseDataLoding ==
                                                      false &&
                                                  searchController.text.isEmpty
                                              ? Provider.of<GetProductProvider>(
                                                              context)
                                                          .ircularProgressLOading ==
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
                                                            if (Provider.of<GetProductProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isNextListDataLoding ==
                                                                false) {
                                                              Provider.of<GetProductProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getFirebaseData(
                                                                widget
                                                                    .subCategory,
                                                                Provider.of<GetProductProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .productList
                                                                    .last
                                                                    .lastdoc,
                                                              );
                                                            }
                                                          },
                                                          child: Provider.of<GetProductProvider>(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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




// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerceadminweb/general/app_colors.dart';
// import 'package:ecommerceadminweb/models/catergory_model.dart';

// import 'package:ecommerceadminweb/provider/get_product_provider.dart';
// import 'package:ecommerceadminweb/screens/product_edit_screen.dart';
// import 'package:ecommerceadminweb/widgets/product_frame.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Enums/product_edit_enum.dart';
// import '../models/product_details_model.dart';
// import '../widgets/custom_popup.dart';

// class ProductsDisplayScreen extends StatefulWidget {
//   const ProductsDisplayScreen({super.key, required this.categorydetails});
//   final CategoryModel categorydetails;
//   @override
//   State<ProductsDisplayScreen> createState() => _ProductsDisplayScreenState();
// }

// class _ProductsDisplayScreenState extends State<ProductsDisplayScreen> {
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//         Provider.of<GetProductProvider>(context, listen: false)
//             .clearData();
//         Provider.of<GetProductProvider>(context, listen: false)
//             .getFirebaseData(widget.categorydetails,widget.categorydetails, null);
//       },
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             iconTheme: const IconThemeData(
//               color: Colors.black,
//             ),
//             scrolledUnderElevation: 5,
//             elevation: 10,
//             pinned: true,
//             backgroundColor: Colors.white,
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.categorydetails.name,
//                   style: const TextStyle(
//                     fontFamily: "pop",
//                     color: Colors.black,
//                   ),
//                 ),
//                 Card(
//                   elevation: 1,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.zero,
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.search,
//                             color: appcolor1,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                           height: 30,
//                           width: MediaQuery.of(context).size.width / 5,
//                           child: TextField(
//                             controller: searchController,
//                             onChanged: (value) {
//                               Provider.of<GetProductProvider>(context,
//                                       listen: false)
//                                   .getSearchProduct(
//  ,widget.categorydetails                                     value, widget.categorydetails);
//                             },
//                             decoration: const InputDecoration(
//                                 contentPadding: EdgeInsets.only(
//                                     bottom: 15, left: 10, right: 5),
//                                 border: InputBorder.none),
//                           )),
//                       Container(
//                         height: 20,
//                         width: 1,
//                         color: Colors.black,
//                       ),
//                       IconButton(
//                         onPressed: () async {
                          // searchController.clear();
                          // setState(() {});
                          // await Provider.of<GetProductProvider>(context,
                          //         listen: false)
                          //     .getFirebaseData(widget.categorydetails,widget.categorydetails, null);
//                         },
//                         icon: const Icon(
//                           Icons.close,
//                           color: appcolor1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(),
//               ],
//             ),
//           ),
//           SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               sliver: Provider.of<GetProductProvider>(
//                         context,
//                       ).isFirebaseDataLoding ==
//                       false
//                   ? Provider.of<GetProductProvider>(
//                       context,
//                     ).productList.isNotEmpty
//                       ? SliverGrid(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 4,
//                                   crossAxisSpacing: 10,
//                                   mainAxisSpacing: 10,
//                                   childAspectRatio: 2 / 2),
//                           delegate: SliverChildBuilderDelegate(
//                             childCount: Provider.of<GetProductProvider>(context)
//                                 .productList
//                                 .length,
//                             (context, index) {
//                               return ProductFrame(
//                                 productDetails:
//                                     Provider.of<GetProductProvider>(context)
//                                         .productList[index],
//                                 delete: () {
//                                   customPoPup(
//                                       context, "Delete", "Delete this product",
//                                       () {
//                                     log("Delete");
//                                     FirebaseFirestore.instance
//                                         .collection("products")
//                                         .doc(
//                                             "${Provider.of<GetProductProvider>(context, listen: false).productList[index].productID}")
//                                         .delete();
//                                     Provider.of<GetProductProvider>(context,
//                                             listen: false)
//                                         .removeAt(index);

//                                     /// last 12 ennam ayaalum and circularProgressLOading==true annegil veendum data get cheyyan
//                                     List<ProductDetailsModel> productList =
//                                         Provider.of<GetProductProvider>(context,
//                                                 listen: false)
//                                             .productList;
//                                     if (productList.length <= 8 &&
//                                         Provider.of<GetProductProvider>(context,
//                                                     listen: false)
//                                                 .circularProgressLOading ==
//                                             true) {
//                                       Provider.of<GetProductProvider>(context,
//                                               listen: false)
//                                           .getFirebaseData(widget.categorydetails,
//                                               widget.categorydetails,
//                                               productList.last.lastdoc);
//                                     }
//                                     //
//                                     if (productList.isEmpty) {
//                                       Provider.of<GetProductProvider>(context,
//                                               listen: false)
//                                           .getFirebaseData(widget.categorydetails,
//                                               widget.categorydetails, null);
//                                     }

//                                     Navigator.pop(context);
//                                   }, "OK");
//                                 },
                              //   edit: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) {
                              //           return ProductEditScreen(
                              //                productEditEnum: ProductEditEnum.productEditer,
                              //               productDetails:
                              //                   Provider.of<GetProductProvider>(
                              //                           context,
                              //                           listen: false)
                              //                       .productList[index]);
                              //         },
                              //       ),
                              //     );
                              //   },
                              // );
//                             },
//                           ),
//                         )
//                       : SliverToBoxAdapter(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height / 2.5,
//                               ),
//                               Center(
//                                 child: Text(
//                                   searchController.text.isEmpty
//                                       ? "Product is empty...     "
//                                       : 'No results found for "${searchController.text}" ',
//                                   style: const TextStyle(
//                                     fontFamily: "pop",
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                   : SliverToBoxAdapter(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height / 2.5,
//                           ),
//                           const Center(
//                             child: CircularProgressIndicator(
//                               color: appcolor1,
//                               strokeWidth: 2,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//           SliverToBoxAdapter(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Provider.of<GetProductProvider>(context).isFirebaseDataLoding ==
//                           false &&
//                       searchController.text.isEmpty
//                   ? Provider.of<GetProductProvider>(context)
//                               .circularProgressLOading ==
//                           true
//                       ? Tooltip(
//                           message: "Get the next list",
//                           child: Container(
//                             margin: const EdgeInsets.all(10),
//                             height: 45,
//                             width: 45,
//                             child: MaterialButton(
//                               elevation: 3,
//                               color: Colors.white,
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(200))),
//                               onPressed: () {
//                                 if (Provider.of<GetProductProvider>(context,
//                                             listen: false)
//                                         .isNextListDataLoding ==
//                                     false) {
//                                   Provider.of<GetProductProvider>(context,
//                                           listen: false)
//                                       .getFirebaseData(widget.categorydetails,
//                                     widget.categorydetails,
//                                     Provider.of<GetProductProvider>(context,
//                                             listen: false)
//                                         .productList
//                                         .last
//                                         .lastdoc,
//                                   );
//                                 }
//                               },
//                               child: Provider.of<GetProductProvider>(context)
//                                           .isNextListDataLoding ==
//                                       false
//                                   ? const Icon(
//                                       CupertinoIcons.add,
//                                       color: Colors.black,
//                                       size: 22,
//                                     )
//                                   : const Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 0.0, vertical: 8),
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         )
//                       : Container()
//                   : Container(),
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }
