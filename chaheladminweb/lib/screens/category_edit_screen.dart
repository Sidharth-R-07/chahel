import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/provider/get_catergory_provider.dart';
import 'package:ecommerceadminweb/services/build_search_keywords.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/image_pick.provider.dart';
import '../services/upload_firestore_image_services.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_toast.dart';
import '../widgets/shimmer.dart';

void showDialogEditcategory(
  context,
  CategoryModel categoryDetails,
) {
  TextEditingController categorycontroller =
      TextEditingController(text: categoryDetails.name);
  Uint8List? image;
  log(categoryDetails.image.toString());
  bool isFirebaseuploading = false;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return ListView(
            children: [
              AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20.0,
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Create catergory.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "pop",
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  reverse: true,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          final pickimage =
                              await Provider.of<CustomPickImageProvider>(
                                      context,
                                      listen: false)
                                  .pickimage();
                          if (pickimage == null) return;
                          image = pickimage;
                          setState(
                            () {},
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.zero,
                            height: 200,
                            width: 200,
                            color: Colors.white,
                            child: image != null
                                ? Image.memory(
                                    image ??
                                        base64Decode(categoryDetails.image),
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: categoryDetails.image,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const CustomShimmer(
                                      radius: 10,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 12),
                        child: SizedBox(
                            width: 210,
                            child: CustomTextfield(
                                controller: categorycontroller,
                                labelText: "Category name.",
                                maxLines: 1)),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (isFirebaseuploading == false) {
                              if (categoryDetails.image.isEmpty) {
                                erroetoast("Please add image.");
                              } else if (categorycontroller.text.isEmpty) {
                                erroetoast("Please add category name.");
                              } else {
                                setState(
                                  () {
                                    isFirebaseuploading = true;
                                  },
                                );
                                String? url;
                                if (image != null) {
                                  url = await uploadFirestoreImageServices(
                                      image!);
                                }

                                FirebaseFirestore.instance
                                    .collection("category")
                                    .doc(categoryDetails.categoryID)
                                    .update(
                                  {
                                    "image": image != null
                                        ? url
                                        : categoryDetails.image,
                                    "keywords": keywordsBuilder(
                                        categorycontroller.text),
                                    "name": categorycontroller.text,
                                  },
                                );
                                Provider.of<GetCatergoryProvider>(context,
                                        listen: false)
                                    .localedit(CategoryModel(
                                  image: (image != null
                                      ? (url ?? "")
                                      : categoryDetails.image),
                                  name: categorycontroller.text,
                                  categoryID: categoryDetails.categoryID,
                                ));
                                setState(
                                  () {
                                    isFirebaseuploading = false;
                                  },
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            } else {}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            // fixedSize: Size(250, 50),
                          ),
                          child: isFirebaseuploading == false
                              ? const Text(
                                  "Add",
                                )
                              : const CupertinoActivityIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isFirebaseuploading == false
                      ? Material(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          color: Colors.white.withOpacity(.3),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        )
                      : const Text(
                          "Please wait...",
                          style: TextStyle(
                            fontFamily: "pop",
                            color: Colors.white,
                          ),
                        )
                ],
              ),
            ],
          );
        });
      });
}
