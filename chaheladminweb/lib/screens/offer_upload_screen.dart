import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/services/upload_firestore_image_services.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/offer_model.dart';
import '../provider/image_pick.provider.dart';
import '../widgets/custom_toast.dart';

void showDialogAddoffer(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

        Uint8List? image1;
        Uint8List? image2;
        Uint8List? image3;
        Uint8List? image4;
        bool isFirebaseuploading = false;
        TextEditingController offerEditingController=TextEditingController();
        int designNumber=0;
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
                      "Create offer.",
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            //1
                            InkWell(
                              onTap: () async {
                              final  pickimage = await Provider.of<CustomPickImageProvider>(context,listen: false).pickimage();
                                  if (pickimage==null)  return;  
                                      image1=pickimage;  
                                    
                                setState(
                                  () {},
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    padding: EdgeInsets.zero,
                                    height: 300,
                                    width: 200,
                                    color: Colors.white,
                                    child: image1 != null
                                        ? Image.memory(
                                            image1!,
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
                            // 2
                                 InkWell(
                          onTap: () async {
                          final  pickimage = await Provider.of<CustomPickImageProvider>(context,listen: false).pickimage();
                              if (pickimage==null)  return;  
                                  image2=pickimage;  
                                
                            setState(
                              () {},
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                padding: EdgeInsets.zero,
                                height: 300,
                                width: 200,
                                color: Colors.white,
                                child: image2 != null
                                    ? Image.memory(
                                        image2!,
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
                        //3
                             InkWell(
                          onTap: () async {
                          final  pickimage = await Provider.of<CustomPickImageProvider>(context,listen: false).pickimage();
                              if (pickimage==null)  return;  
                                  image3=pickimage;  
                                
                            setState(
                              () {},
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                padding: EdgeInsets.zero,
                                height: 300,
                                width: 200,
                                color: Colors.white,
                                child: image3 != null
                                    ? Image.memory(
                                        image3!,
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
                        //4
                             InkWell(
                          onTap: () async {
                          final  pickimage = await Provider.of<CustomPickImageProvider>(context,listen: false).pickimage();
                              if (pickimage==null)  return;  
                                  image4=pickimage;  
                                
                            setState(
                              () {},
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                padding: EdgeInsets.zero,
                                height: 300,
                                width: 200,
                                color: Colors.white,
                                child: image4 != null
                                    ? Image.memory(
                                        image4!,
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
                          ],
                        ),
                      ),
                         Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 12),
                        child: CustomTextfield(
                            controller: offerEditingController,
                            labelText: "Offer name.",
                            maxLines: 1),
                      ),
                            Card(
                              elevation: 2,
                              shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PopupMenuButton(
                                          child: Text(designNumber==1?"Grid":designNumber==2?"Array":"design.",style:const TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w800,
                                                
                                               ),),
                                        itemBuilder: (ctx) => [
                            
                                        PopupMenuItem(
                                          
                                          value: 2,
                                          child:  Row(
                                            children:const [
                                              Icon(Icons.view_array_outlined),
                                              SizedBox(width: 5,),
                                              Text("Array",style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w800,
                                                
                                               ),),
                                            ],
                                          ),
                                        ),     PopupMenuItem(
                                          value: 1,
                                          child:  Row(
                                            children:const [
                                              Icon(Icons.grid_view),
                                              SizedBox(width: 5,),
                                              Text("Grid",style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w800,
                                                
                                               ),),
                                            ],
                                          ),
                                        ),
                                              ],
                                              onSelected: (value) {
                                                 if(value==1){
                                                 designNumber=1;
                                                }else{
                                                  designNumber=2; 
                                                }
                                                setState(() {
                                                  
                                                },);
                                              },
                                      ),
                              ),
                            ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (isFirebaseuploading == false) {
                              if (image1 == null&&image2 == null&&image3 == null&&image4 == null) {
                                erroetoast("Please add 4 pictures.");
                              }else if(offerEditingController.text.isEmpty){
                                 erroetoast("Please enter offer name.");
                              } else if(designNumber==0){
                                  erroetoast("please select offer design.");
                              }
                              else { 
                                setState(
                                  () {
                                    isFirebaseuploading = true;
                                  },
                                );
                               List<Uint8List>  offerimages=[
                                  image1!,image2!,image3!,image4!,
                               ];
                                //
                                Map offers={};
                                for (var i = 0; i < offerimages.length; i++) {
                                  String? url =await uploadFirestoreImageServices(offerimages[i]);

                                  offers[const Uuid().v4()]={
                                    "byteimage":url,
                                    "timestamp": Timestamp.now(),
                                  };
                                
                                   
                                }
                                

                                FirebaseFirestore.instance
                                    .collection("offer")
                                    .doc()
                                    .set(
                                  {
                                    "offers":offers,
                                    "name":offerEditingController.text,
                                    "designindex":designNumber,
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
