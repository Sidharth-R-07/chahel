import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/provider/get_catergory_provider.dart';
import 'package:ecommerceadminweb/services/build_search_keywords.dart';
import 'package:ecommerceadminweb/services/upload_firestore_image_services.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/image_pick.provider.dart';
import '../widgets/custom_toast.dart';

void showDialogAddcategory(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        TextEditingController categorycontroller = TextEditingController();
        Uint8List? image;

        bool isFirebaseuploading = false;
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
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                      image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add),
                                        Text("Add image"),
                                      ],
                                    )),
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
                              if (image == null) {
                                erroetoast("Please add image.");
                              } else if (categorycontroller.text.isEmpty) {
                                erroetoast("Please add category name.");
                              } else {
                                setState(
                                  () {
                                    isFirebaseuploading = true;
                                  },
                                );
                                String? url =
                                    await uploadFirestoreImageServices(image!);
                                String newid = FirebaseFirestore.instance
                                    .collection("category")
                                    .doc()
                                    .id;

                                FirebaseFirestore.instance
                                    .collection("category")
                                    .doc(newid)
                                    .set(
                                  {
                                    "image": url,
                                    "name": categorycontroller.text,
                                    "keywords": keywordsBuilder(
                                        categorycontroller.text),
                                    "timestamp": Timestamp.now(),
                                    "categoryId": newid
                                  },
                                );

                                setState(
                                  () {
                                    isFirebaseuploading = false;
                                  },
                                );
                                // ignore: use_build_context_synchronously
                                Provider.of<GetCatergoryProvider>(context,
                                        listen: false)
                                    .addlocalData(
                                  CategoryModel(
                                    image: url ?? "",
                                    name: categorycontroller.text,
                                    categoryID: newid,
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            } else {}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
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

  //  try {
  // var storage = FirebaseStorage.instance;
  // Reference ref =
  //     storage.ref().child('${Timestamp.now()}.jpeg');
  // await ref
  //     .putData(image!,SettableMetadata(contentType: 'image/jpeg'),
    
    
  // ).whenComplete(() async {
  //   await ref.getDownloadURL().then((value) {
  //    ///
  //    ///FirebaseFirestore
  //    ///
  //    FirebaseFirestore.instance.collection("category").doc().set({
  //     "image":value,
  //     "name":categorycontroller.text,
  //     "timestamp":Timestamp.now(),
  //    },
  //    );
  //    ///
  //    ///FirebaseFirestore
  //    ///
  //    log("uploaded");
  //    ///
  //   });
  // });
  //                           } catch (e) {
  // log("$e upload category error ...");
  //                           }