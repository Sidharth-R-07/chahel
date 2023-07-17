import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/models/offer_model.dart';
import 'package:ecommerceadminweb/screens/banner_product_display_screen.dart';
import 'package:ecommerceadminweb/screens/offer_edit_screen.dart';
import 'package:ecommerceadminweb/screens/offer_product_display_screen.dart';
import 'package:ecommerceadminweb/screens/offer_upload_screen.dart';
import 'package:ecommerceadminweb/widgets/banner_frame.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:ecommerceadminweb/widgets/offer_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_popup.dart';
import 'offer_manage_screen.dart';

class OfferDisplayScreen extends StatefulWidget {
  const OfferDisplayScreen({super.key});

  @override
  State<OfferDisplayScreen> createState() => _OfferDisplayScreenState();
}

class _OfferDisplayScreenState extends State<OfferDisplayScreen> {
    List<OfferModel> offerList=[];
  bool getFirebasegetData=false;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
     
      slivers: [
     SliverAppBar(
      scrolledUnderElevation: 5,
      elevation: 10,
      pinned: true,
      backgroundColor: Colors.white,
        
          actions: [
          
            IconButton(onPressed: (){
              if (getFirebasegetData) {
                if ((offerList.length)==5) {
                  erroetoast("The maximum number of offers that can be placed is '5'");
                }else{
                 showDialogAddoffer(context);
                }
              }else{
                normeltoast("Please wait.");
              }
                        
            
            },
             icon:const Icon(Icons.add),
             tooltip: "add offers",
            color: Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
          ],
      ),
           SliverPadding(
       padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
       sliver: 
       StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
         stream: FirebaseFirestore.instance.collection("offer")
         .limit(5)
         .orderBy("timestamp", descending: true)
         .snapshots(),
         builder: (context, snapshot) {
           if (snapshot.connectionState==ConnectionState.active) {
            
              offerList=[];
              getFirebasegetData=true;
              Future.delayed(Duration.zero,(){
           
              });
             
              for (QueryDocumentSnapshot<Map<String, dynamic>> element in snapshot.data?.docs??[]) {
                 List<OfferAndIdModel> offerAndIdList=[];
                 (element.data()["offers"]??{}).forEach((key, value) {
                     log(key);
                     log(value["byteimage"]);
                     offerAndIdList.add(
                      OfferAndIdModel(image: value["byteimage"],
                      timestamp: value["timestamp"],
                       iD:  key)
                     );
                  });
                  offerAndIdList.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
                offerList.add(
                OfferModel(
                  offerAndIdList: offerAndIdList,
                  designNumber: element.data()["designindex"],
                  name: element.data()["name"],
                  offerID: element.id,
                ),
                );
              }
             // offerDetails.offerAndIdList.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
              return offerList.isNotEmpty? SliverGrid(
   
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio: 2/3.2),
           delegate: SliverChildBuilderDelegate(
             
             childCount:  offerList.length,///
            (context, index) {
              return OfferFrame(offerDetails: offerList[index],
              manageoffer: (){
                manageofferScreen(context,offerList[index]);
              },
              edit: (){
                showDialogEditoffer(context, offerList[index]);
              },
              delete: (){
                   customPoPup(
                                  context, "Delete", "Delete this offer", () {
                               
                                FirebaseFirestore.instance
                                    .collection("offer")
                                    .doc(offerList[index].offerID)
                                    .delete();
                                  
                                    Navigator.pop(context);
                              }, "OK");
              },
              );
            },
           ),):
          SliverToBoxAdapter(

                  child:     Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                     const Center(
                          child: Text("Offers is empty...     ",style: TextStyle(
                            fontFamily: "pop",
                            color: Colors.black,
                          ),),
                        ),
                    ],
                  ),
                );


}else{
  return SliverToBoxAdapter(

                  child:     Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                     const Center(
                          child:CupertinoActivityIndicator(),
                        ),
                    ],
                  ),
                );
}
         }
       )
            
     ),

  ]
 
    );
  }
}