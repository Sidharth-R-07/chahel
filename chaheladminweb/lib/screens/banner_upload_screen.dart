import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/image_pick.provider.dart';
import '../services/upload_firestore_image_services.dart';
import '../widgets/custom_toast.dart';

void showDialogAddBanner(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

        Uint8List? image;
        bool isFirebaseuploading = false;
        return StatefulBuilder(builder: (context, setState) {
          return ListView(
            shrinkWrap: true,
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
                      "Create banner.",
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
                        final  pickimage = await Provider.of<CustomPickImageProvider>(context,listen: false).pickimage();
                            if (pickimage==null)  return;  
                                image=pickimage;  
                              
                          setState(
                            () {},
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                              padding: EdgeInsets.zero,
                              height: 200,
                              width: 300,
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
                   
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (isFirebaseuploading == false) {
                              if (image == null) {
                                erroetoast("Please add image.");
                              }  else {
                                setState(
                                  () {
                                    isFirebaseuploading = true;
                                  },
                                );
                                 String? url =await uploadFirestoreImageServices(image!);
                                 
                                FirebaseFirestore.instance
                                    .collection("banner")
                                    .doc()
                                    .set(
                                  {
                                    "image": url,
                                    "timestamp": Timestamp.now(),
                                  },
                                );
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
