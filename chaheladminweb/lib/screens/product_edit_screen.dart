import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerceadminweb/Enums/product_edit_enum.dart';
import 'package:ecommerceadminweb/provider/get_all_product_provider.dart';
import 'package:ecommerceadminweb/provider/get_product_provider.dart';
import 'package:ecommerceadminweb/services/build_search_keywords.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../general/app_colors.dart';
import '../models/netimage_byetimage_separating_model.dart.dart';
import '../models/product_details_model.dart';
import '../models/product_parameters_model.dart';
import '../provider/image_pick.provider.dart';
import '../provider/product_parameters_provider.dart';
import '../provider/product_unit_provider.dart';
import '../services/upload_firestore_image_services.dart';
import '../widgets/creat_unit_box.dart';
import '../widgets/custom_circular_progress.dart';
import '../widgets/custom_product_textfield.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_toast.dart';
import '../widgets/product_parameters_boxs.dart';
import 'manage_unit_screen.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen(
      {super.key, required this.productDetails, required this.productEditEnum});
  final ProductEditEnum productEditEnum;
  final ProductDetailsModel productDetails;

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final key = GlobalKey();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<NetimageByetimageSeparatingModel> imageList = [];
  //firstimage
  Uint8List? byetimage;
  NetimageByetimageSeparatingModel? firstimage;
  //firstimage end
  bool isStockOut = false;
  final List<String> items = [
    'Select Item',
    'Veg',
    'Non Veg',
  ];
  String? productTypeValue;
  bool? productType;
  bool? toggleReviewStatus;
  @override
  void initState() {
    // clearData();
    getoldProduct();

    log("PRODECT WIDGET REVEIW STATUS:${widget.productDetails.reviewStatus}");
    //
    Future.delayed(Duration.zero, () {
      Provider.of<ProductUnitProvider>(context, listen: false)
          .getUnitsFirebase(); //get unit
    });
    super.initState();
  }

  @override
  void dispose() {
    // Provider.of<ProductParametersProvider>(context,listen: false).productParametersList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
            onPressed: () {
              Provider.of<ProductParametersProvider>(context, listen: false)
                  .clearData();

              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        // title: Text(widget.categorydetails.name,style:const TextStyle(
        //   fontFamily: "pop",
        //   color: Colors.black,
        // ),),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
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
              const PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
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
              if (value == 2) {
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
              SizedBox(
                height: 35,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    buttonPadding: const EdgeInsets.only(left: 5),
                    buttonDecoration: BoxDecoration(
                      border: Border.all(
                        width: .5,
                        color: const Color.fromARGB(255, 99, 98, 98),
                      ),
                    ),
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: productTypeValue,
                    onChanged: (value) {
                      if (value == "Veg") {
                        productType = true;
                      } else if (value == "Non Veg") {
                        productType = false;
                      } else {
                        productType = null;
                      }
                      productTypeValue = value;

                      setState(() {});
                    },
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                  ),
                ),
              ),
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
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Productive first image.",
                style: TextStyle(
                  fontFamily: "pop",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  Uint8List? image = await Provider.of<CustomPickImageProvider>(
                          context,
                          listen: false)
                      .pickimage();
                  if (image == null) return;
                  byetimage = image;
                  firstimage = NetimageByetimageSeparatingModel(
                    imageType: false,
                    image: image,
                  );
                  setState(() {});
                },
                child: Card(
                  elevation: 4,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        height: 200,
                        width: 200,
                        child: firstimage?.imageType == false
                            ? Image(
                                image: MemoryImage(firstimage?.image),
                                gaplessPlayback: true,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: firstimage?.image,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.shade200,
                                        highlightColor: Colors.grey.shade100,
                                        period:
                                            const Duration(milliseconds: 500),
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          color: Colors.white,
                                        )),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: const Icon(Icons.change_circle_outlined,
                            color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          ///add image
          imageList.isEmpty
              ? Row(
                  children: [
                    InkWell(
                      onTap: pickimage, //pick image
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
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
                      itemCount: imageList.length,
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
                                    child: imageList[index].imageType == false
                                        ? Image(
                                            image: MemoryImage(
                                                imageList[index].image),
                                            gaplessPlayback: true,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: imageList[index].image,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade200,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    period: const Duration(
                                                        milliseconds: 500),
                                                    child: Container(
                                                      height: 200,
                                                      width: 200,
                                                      color: Colors.white,
                                                    )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      imageList.removeAt(index);
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
                            index == imageList.length - 1 &&
                                    (imageList.length + 1) <= 2
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
//----------------------------------------SHOWING REVEIW STATUS------------------------------------------
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('User allow to reviewing product?'),
              const SizedBox(width: 25),
              Switch(
                  value: toggleReviewStatus ?? false,
                  activeColor: appcolor1,
                  onChanged: (val) {
                    setState(() {
                      toggleReviewStatus = val;
                    });
                  })
            ],
          ),
          Row(
            children: [
              MaterialButton(
                color: uploadButtonColors,
                height: 50,
                onPressed: uploadProduct,
                child: const Text(
                  "Edit",
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
                color: const Color.fromARGB(255, 125, 105, 236),
                height: 50,
                onPressed: getoldProduct,
                child: const Text(
                  "Reset",
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
    imageList.add(NetimageByetimageSeparatingModel(
      imageType: false,
      image: image,
    ));
    setState(() {});
  }

  void uploadProduct() async {
    ///unit errors
    log("1");
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
    } else
    // if(imageList.isEmpty){
    //    erroetoast("Please add product image.");
    // }else
    if (descriptionController.text.isEmpty) {
      erroetoast("Please enter product description.");
    } else {
      log("2");
      customCircularProgressIndicator(context, key);

      log("3");
      //product Parameters List > convert > product Parameters 'Map' List
      Map<String, Map<String, dynamic>> productParametersMapofmap = {};
      int positionindex = 0;
      for (var element
          in Provider.of<ProductParametersProvider>(context, listen: false)
              .productParametersList) {
        ///chack stock out product unit
        if ((element.stock ?? 0) == 0) {
          isStockOut = true;
        }
        positionindex = (positionindex + 1);

        ///chack stock out product unit end
        productParametersMapofmap["${element.uint}"] = {
          "uint": element.uint,
          "mrp": (element.mrp ?? 0),
          "rs": (element.rs ?? 0),
          "stock": (element.stock ?? 0),
          "index": positionindex,
        };
      }
      //product Parameters List > convert > product Parameters 'Map' List end

      List<NetimageByetimageSeparatingModel> fullImage = [];
      //firstimage add full image list
      fullImage.add(firstimage!);
      // other imagelist add
      fullImage.addAll(imageList);

      List<String> imageUrlList = [];

      /// get image url
      /// new byet image convert net image
      for (var i = 0; i < fullImage.length; i++) {
        if (fullImage[i].imageType == false) {
          String? url = await uploadFirestoreImageServices(fullImage[i].image);

          if (url == null) return;

          imageUrlList.add(url);
        } else {
          imageUrlList.add(fullImage[i].image);
        }
      }

      if (byetimage == null) {
        log("error byet image");
        return;
      }

      /// product add firebase FirebaseFirestore
      FirebaseFirestore.instance
          .collection("products")
          .doc(widget.productDetails.productID)
          .update({
        "name": productNameController.text,
        "keywords": keywordsBuilder(productNameController.text),
        "parameters": productParametersMapofmap,
        "image": imageUrlList,
        "byetimage": "", //base64Encode(byetimage!),
        "description": descriptionController.text,
        //
        "stockout": isStockOut,
        "reviewStatus": toggleReviewStatus,
        "productType": productType,
      });

      ///local edit

      List<ProductParametersModel> productParametersList = [];

      productParametersMapofmap.forEach((key, value) {
        productParametersList.add(ProductParametersModel(
          parametersID: key,
          uint: value["uint"],
          mrp: value["mrp"],
          rs: value["rs"],
          stock: value["stock"],
        ));
      });
      ProductDetailsModel localeditData = ProductDetailsModel(
          name: productNameController.text,
          byetimage: base64Encode(byetimage!),
          image: imageUrlList,
          productID: widget.productDetails.productID,
          description: descriptionController.text,
          productParameters: productParametersList,
          productType: productType,
          reviewStatus: widget.productDetails.reviewStatus);

      // ignore: use_build_context_synchronously

      if (widget.productEditEnum == ProductEditEnum.allproductEditer) {
        // ignore: use_build_context_synchronously
        Provider.of<GetAllProductProvider>(context, listen: false)
            .localedit(localeditData);
      } else if (widget.productEditEnum == ProductEditEnum.productEditer) {
        // ignore: use_build_context_synchronously
        Provider.of<GetProductProvider>(context, listen: false)
            .localedit(localeditData);
      } else if (widget.productEditEnum == ProductEditEnum.stockEditer) {
        // ignore: use_build_context_synchronously
        // Provider.of<StockOutProvider>(context,listen: false).localedit(
        // localeditData
        // );
      }

      ///local edit end

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //clearData();
      saccesstoast("Product edited successfully.");
    }
  }

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

  void getoldProduct() {
    imageList = [];
    Provider.of<ProductParametersProvider>(context, listen: false)
        .productParametersList
        .clear();
    //
    productNameController.text = widget.productDetails.name;

    toggleReviewStatus = widget.productDetails.reviewStatus;

    //product type
    if (widget.productDetails.productType == true) {
      items[1];
      productTypeValue = items[1];
    } else if (widget.productDetails.productType == false) {
      items[2];
      productTypeValue = items[2];
    } else {
      items[0];
      productTypeValue = items[0];
    }
    //product type end
    ///Product Parameter
    for (ProductParametersModel element
        in widget.productDetails.productParameters ?? []) {
      Provider.of<ProductParametersProvider>(context, listen: false)
          .productParametersList
          .add(ProductParametersModel(
            mrp: element.mrp,
            rs: element.rs,
            stock: element.stock,
            uint: element.uint,
          ));
    }

    //Product Parameter end
    byetimage = base64Decode(widget.productDetails.byetimage ?? "");
    for (var element in widget.productDetails.image) {
      if (widget.productDetails.image[0] == element) {
        firstimage = NetimageByetimageSeparatingModel(
          imageType: true,
          image: element,
        );
      } else {
        imageList.add(
          NetimageByetimageSeparatingModel(
            imageType: true,
            image: element,
          ),
        );
      }
    }
    descriptionController.text = widget.productDetails.description;
    log("GET PRODUCT REVIEW TOGGL: $toggleReviewStatus");

    setState(() {});
  }
}
