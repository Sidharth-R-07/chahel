import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/models/sub_category_model.dart';
import 'package:ecommerceadminweb/provider/image_pick.provider.dart';

import 'package:ecommerceadminweb/provider/product_parameters_provider.dart';
import 'package:ecommerceadminweb/provider/product_unit_provider.dart';
import 'package:ecommerceadminweb/screens/products_display_screen.dart';
import 'package:ecommerceadminweb/screens/manage_unit_screen.dart';
import 'package:ecommerceadminweb/services/build_search_keywords.dart';
import 'package:ecommerceadminweb/services/upload_firestore_image_services.dart';
import 'package:ecommerceadminweb/widgets/creat_unit_box.dart';
import 'package:ecommerceadminweb/widgets/custom_circular_progress.dart';
import 'package:ecommerceadminweb/widgets/custom_product_textfield.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';
import 'package:ecommerceadminweb/widgets/product_parameters_boxs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_toast.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key, required this.subCategoryModel});
  final SubCategoryModel subCategoryModel;

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final key = GlobalKey();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Uint8List> byetimageList = [];
  bool isStockOut = false;

  bool toggleReviewStatus = true;

  //
  final List<String> items = [
    'Select Item',
    'Veg',
    'Non Veg',
  ];
  String? productTypeValue;
  bool? productType;
  @override
  void initState() {
    log("UPLOAD SCREEN CALLED");
    clearData();
    //
    if (Provider.of<ProductParametersProvider>(context, listen: false)
        .productParametersList
        .isEmpty) {
      Provider.of<ProductParametersProvider>(context, listen: false)
          .addProductParametersBox();
    }
    Future.delayed(Duration.zero, () {
      Provider.of<ProductUnitProvider>(context, listen: false)
          .getUnitsFirebase(); //get unit
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.subCategoryModel.title!,
          style: const TextStyle(
            fontFamily: "pop",
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.grid_view_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Manage products",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.add_circle_outline_rounded),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add uint",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: const [
                    Icon(Icons.format_align_center),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Manage uint",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductsDisplayScreen(
                        subCategory: widget.subCategoryModel,
                      );
                    },
                  ),
                );
              } else if (value == 2) {
                creatUnit(context);
              } else {
                manageUnitscreen(context);
              }
            },
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Product Name *",
            style: TextStyle(
              fontFamily: "pop",
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          ///
          ///
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    child: CustomProductTextfield(
                        controller: productNameController)),
              ),

              ///
              ///
              ///
              const SizedBox(
                width: 15,
              ),

              //----------------------------------------SHOWING  CATEGORY SELection dropdown-----------------------
              // SizedBox(
              //   height: 35,
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton2(
              //       buttonPadding: const EdgeInsets.only(left: 5),
              //       buttonDecoration: BoxDecoration(
              //         border: Border.all(
              //           width: .5,
              //           color: const Color.fromARGB(255, 99, 98, 98),
              //         ),
              //       ),
              //       hint: Text(
              //         'Select Item',
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: Theme.of(context).hintColor,
              //         ),
              //       ),
              //       items: items
              //           .map((item) => DropdownMenuItem<String>(
              //                 value: item,
              //                 child: Text(
              //                   item,
              //                   style: const TextStyle(
              //                     fontSize: 14,
              //                   ),
              //                 ),
              //               ))
              //           .toList(),
              //       value: productTypeValue,
              //       onChanged: (value) {
              //         if (value == "Veg") {
              //           productType = true;
              //         } else if (value == "Non Veg") {
              //           productType = false;
              //         } else {
              //           productType = null;
              //         }
              //         productTypeValue = value;

              //         setState(() {});
              //       },
              //       buttonHeight: 40,
              //       buttonWidth: 140,
              //       itemHeight: 40,
              //     ),
              //   ),
              // ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),

          ///
          ///
          const SizedBox(
            height: 30,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Provider.of<ProductParametersProvider>(context)
                .productParametersList
                .length,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(Provider.of<ProductParametersProvider>(context).productParametersList[index].stock.toString()),
                  Expanded(
                    child: ProductParametersBoxs(
                      customProductDetails:
                          Provider.of<ProductParametersProvider>(context)
                              .productParametersList[index],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  index == 0
                      ? Column(
                          children: [
                            const Text(
                              "Variation",
                              style: TextStyle(fontFamily: "pop"),
                            ),
                            IconButton(
                                onPressed: () {
                                  Provider.of<ProductParametersProvider>(
                                          context,
                                          listen: false)
                                      .addProductParametersBox();
                                },
                                icon: const Icon(Icons.add),
                                tooltip: "Add variation of product"),
                          ],
                        )
                      : Column(
                          children: [
                            const Text(
                              "Remove",
                              style: TextStyle(fontFamily: "pop"),
                            ),
                            IconButton(
                                onPressed: () {
                                  Provider.of<ProductParametersProvider>(
                                          context,
                                          listen: false)
                                      .removeProductParametersBox(
                                    index,
                                  );
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                tooltip: "Remove variation of product"),
                          ],
                        )
                ],
              );
            },
          ),

          ///add image
          byetimageList.isEmpty
              ? Row(
                  children: [
                    InkWell(
                      onTap: pickimage, //pick image
                      child: const Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text(
                                "Add image",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: byetimageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Card(
                              margin: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    height: 200,
                                    width: 200,
                                    child: Image(
                                      image: MemoryImage(byetimageList[index]),
                                      gaplessPlayback: true,
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      byetimageList.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            index == byetimageList.length - 1 &&
                                    (byetimageList.length + 1) <= 3
                                ? InkWell(
                                    onTap: pickimage, //pick image
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        height: 200,
                                        width: 200,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add),
                                            Text(
                                              "Add image",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        );
                      }),
                ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Description :",
            style: TextStyle(
              fontFamily: "pop",
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextfield(
            controller: descriptionController,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),

//--------------------------------TOGGOLE ADD REVIEW FEILD-----------------------------------------------------------------------------
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('User allow to reviewing product?'),
              const SizedBox(width: 25),
              Switch(
                  value: toggleReviewStatus,
                  activeColor: appcolor1,
                  onChanged: (val) {
                    setState(() {
                      toggleReviewStatus = val;
                    });
                  })
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              MaterialButton(
                color: uploadButtonColors,
                height: 50,
                onPressed: uploadProduct,
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "pop",
                    color: Colors.black,
                  ),
                ),
              ),
              //
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                color: const Color.fromARGB(255, 245, 96, 96),
                height: 50,
                onPressed: clearData,
                child: const Text(
                  "Clear",
                  style: TextStyle(
                    fontFamily: "pop",
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //image
  void pickimage() async {
    Uint8List? image =
        await Provider.of<CustomPickImageProvider>(context, listen: false)
            .pickimage();
    if (image == null) return;
    byetimageList.add(image);
    setState(() {});
  }

  ///
  ///
  ///
  void uploadProduct() async {
    ///unit errors
    for (var element
        in Provider.of<ProductParametersProvider>(context, listen: false)
            .productParametersList) {
      if ((element.uint ?? "") == "") {
        erroetoast(
            "The 'unit' in the ${(Provider.of<ProductParametersProvider>(context, listen: false).productParametersList.indexWhere((e) => element == e) + 1)}"
            "${getindexsaffix((Provider.of<ProductParametersProvider>(context, listen: false).productParametersList.indexWhere((e) => element == e) + 1))} variation box is empty");
        return;
      } else if ((element.rs ?? "") == "") {
        erroetoast(
            "The 'rs' in the ${(Provider.of<ProductParametersProvider>(context, listen: false).productParametersList.indexWhere((e) => element == e) + 1)}"
            "${getindexsaffix((Provider.of<ProductParametersProvider>(context, listen: false).productParametersList.indexWhere((e) => element == e) + 1))} variation box is empty");
        return;
      } else if ((element.stock ?? "") == "") {
        erroetoast(
            "The 'stock' in the ${(Provider.of<ProductParametersProvider>(context, listen: false).productParametersList.indexWhere((e) => element == e) + 1)}"
            "${getindexsaffix((Provider.of<ProductParametersProvider>(context, listen: false).productParametersList.indexWhere((e) => element == e) + 1))} variation box is empty");
        return;
      }
    }

    ///unit errors end
    //
    if (productNameController.text.isEmpty) {
      erroetoast("Please enter product name.");
    } else if (byetimageList.isEmpty) {
      erroetoast("Please add product image.");
    } else if (descriptionController.text.isEmpty) {
      erroetoast("Please enter product description.");
    } else {
      customCircularProgressIndicator(context, key);

      //product Parameters List > convert > product Parameters 'Map' List
      Map<String, Map<String, dynamic>> productParametersMapofmap = {};
      int positionindex = 0;
      for (var element
          in Provider.of<ProductParametersProvider>(context, listen: false)
              .productParametersList) {
        ///
        ///chack stock out product unit
        if ((element.stock ?? 0) == 0) {
          isStockOut = true;
        }
        positionindex = (positionindex + 1);

        ///chack stock out product unit end
        ///
        productParametersMapofmap["${element.uint}"] = {
          "uint": element.uint,
          "mrp": (element.mrp ?? 0),
          "rs": (element.rs ?? 0),
          "stock": (element.stock ?? 0),
          "index": positionindex,
        };
      }
      //product Parameters List > convert > product Parameters 'Map' List end

      /// get image url
      List<String> imageUrlList = [];
      for (var i = 0; i < byetimageList.length; i++) {
        String? url = await uploadFirestoreImageServices(byetimageList[i]);

        if (url == null) return;

        imageUrlList.add(url);
      }

      /// get image url end
      ///
      /// product add firebase FirebaseFirestore
      FirebaseFirestore.instance.collection("products").doc().set({
        "name": productNameController.text,
        "keywords": keywordsBuilder(productNameController.text),
        "parameters": productParametersMapofmap,
        "image": imageUrlList,
        "byetimage": "", //base64Encode(byetimageList[0]),
        "description": descriptionController.text,
        //
        "reviewStatus": toggleReviewStatus,
        "stockout": isStockOut,
        "productType": productType,
        "categoryID": widget.subCategoryModel.categoryId,
        'subCategoryId': widget.subCategoryModel.subCategorId,
        "timestamp": Timestamp.now(),
      });

      /// product add firebase FirebaseFirestore end
      ///
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      clearData();
      saccesstoast("Product uploaded successfully.");
    }
  }

  ////
  ///clear data
  ///
  void clearData() {
    productNameController.clear();
    byetimageList = [];
    productType = null;
    productTypeValue = null;
    descriptionController.clear();
    //
    Provider.of<ProductParametersProvider>(context, listen: false)
        .productParametersList = [];
    if (Provider.of<ProductParametersProvider>(context, listen: false)
        .productParametersList
        .isEmpty) {
      Provider.of<ProductParametersProvider>(context, listen: false)
          .addProductParametersBox();
    }
    setState(() {});
  }

  ////
  ///
  ///
  String getindexsaffix(int index) {
    if (!(index >= 1 && index <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (index >= 11 && index <= 13) {
      return 'th';
    }

    switch (index % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
