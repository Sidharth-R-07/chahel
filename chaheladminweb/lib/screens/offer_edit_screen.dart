import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/offer_model.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/image_pick.provider.dart';
import '../services/upload_firestore_image_services.dart';
import '../widgets/custom_toast.dart';
import '../widgets/shimmer.dart';


void showDialogEditoffer(context,OfferModel offerDetails) {
    Uint8List? image1;
        Uint8List? image2;
        Uint8List? image3;
        Uint8List? image4;
        bool isFirebaseuploading = false;
        TextEditingController offerEditingController=TextEditingController(text: offerDetails.name);
        int designNumber=offerDetails.designNumber;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

      
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
                      "Edit offer.",
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
                                        :CachedNetworkImage(
                                          imageUrl: offerDetails.offerAndIdList[0].image,
                                          width: 200,fit: BoxFit.cover,
                                          placeholder: (context, url) => 
                                     const  CustomShimmer(),
                                          errorWidget: (context, url, error) =>const Icon(Icons.error),
                                      ), ),
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
                                    : CachedNetworkImage(
                                          imageUrl: offerDetails.offerAndIdList[1].image,
                                          width: 200,fit: BoxFit.cover,
                                          placeholder: (context, url) => 
                                     const  CustomShimmer(),
                                          errorWidget: (context, url, error) =>const Icon(Icons.error),
                                      ),),
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
                                    : CachedNetworkImage(
                                          imageUrl: offerDetails.offerAndIdList[2].image,
                                          width: 200,fit: BoxFit.cover,
                                          placeholder: (context, url) => 
                                     const  CustomShimmer(),
                                          errorWidget: (context, url, error) =>const Icon(Icons.error),
                                      ),),
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
                                    : CachedNetworkImage(
                                          imageUrl: offerDetails.offerAndIdList[3].image,
                                          width: 200,fit: BoxFit.cover,
                                          placeholder: (context, url) => 
                                     const  CustomShimmer(),
                                          errorWidget: (context, url, error) =>const Icon(Icons.error),
                                      ),),
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
                              if(offerEditingController.text.isEmpty){
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
                               List<Uint8List?>  offerimages=[
                                  image1,image2,image3,image4,
                               ];
                               log("1");
                                //
                                Map offers={};

                                 if (image1==null) {
                                    offers[offerDetails.offerAndIdList[0].iD]={
                                    "byteimage":offerDetails.offerAndIdList[0].image,
                                    "timestamp":offerDetails.offerAndIdList[0].timestamp
                                  };
                                 }else{
                                      offers[offerDetails.offerAndIdList[0].iD]={
                                    "byteimage":await uploadFirestoreImageServices(offerimages[0]!),
                                    "timestamp":offerDetails.offerAndIdList[0].timestamp
                                 };}

                                 if (image2==null) {
                                    offers[offerDetails.offerAndIdList[1].iD]={
                                    "byteimage":offerDetails.offerAndIdList[1].image,
                                    "timestamp": offerDetails.offerAndIdList[1].timestamp
                                  };
                                 }else{
                                      offers[offerDetails.offerAndIdList[1].iD]={
                                    "byteimage":await uploadFirestoreImageServices(offerimages[1]!),
                                    "timestamp": offerDetails.offerAndIdList[1].timestamp
                                 };}

                                  if (image3==null) {
                                    offers[offerDetails.offerAndIdList[2].iD]={
                                    "byteimage":offerDetails.offerAndIdList[2].image,
                                    "timestamp":offerDetails.offerAndIdList[2].timestamp
                                  };
                                 }else{
                                      offers[offerDetails.offerAndIdList[2].iD]={
                                    "byteimage":await uploadFirestoreImageServices(offerimages[2]!),
                                    "timestamp":offerDetails.offerAndIdList[2].timestamp
                                 };}

                                  if (image4==null) {
                                    offers[offerDetails.offerAndIdList[3].iD]={
                                    "byteimage":offerDetails.offerAndIdList[3].image,
                                    "timestamp": offerDetails.offerAndIdList[3].timestamp
                                  };
                                 }else{
                                      offers[offerDetails.offerAndIdList[3].iD]={
                                    "byteimage":await uploadFirestoreImageServices(offerimages[3]!),
                                    "timestamp": offerDetails.offerAndIdList[3].timestamp
                                 };}




                              //   for (var i = 0; i < offerimages.length; i++) {
                              //     String? url;
                              //     if (offerimages[i]==null) {
                              //          url=await uploadFirestoreImageServices(offerimages[i]!),;
                              //       }else{
                              //         offerDetails.offerAndIdList[i].image;
                              //       }

                              //     offers[offerDetails.offerAndIdList[i].iD]={
                              //       "byteimage":url,
                              //     };

                                
                                     
                              //  }
                                log("2");

                                FirebaseFirestore.instance
                                    .collection("offer")
                                    .doc(offerDetails.offerID)
                                    .update(
                                  {
                                    "offers":offers,
                                    "name":offerEditingController.text,
                                    "designindex":designNumber,
                                    
                                  },
                                );
                                  log("3");
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
                                  "Edit",
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
