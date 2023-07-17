
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/models/banner_model.dart';
import 'package:ecommerceadminweb/models/product_details_model.dart';
import 'package:ecommerceadminweb/models/product_parameters_model.dart';
import 'package:ecommerceadminweb/provider/banner_products_provider.dart';
import 'package:ecommerceadminweb/screens/banner_products_add_screen.dart';
import 'package:ecommerceadminweb/widgets/banner_product_frame.dart';
import 'package:ecommerceadminweb/widgets/custom_popup.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/products_docs_get_model.dart';




class BannerProductDisplayScreen extends StatefulWidget {
  const BannerProductDisplayScreen({super.key,required this.bannerdetails});
  final BannerModel bannerdetails;

  @override
  State<BannerProductDisplayScreen> createState() => _BannerProductDisplayScreenState();
}

class _BannerProductDisplayScreenState extends State<BannerProductDisplayScreen> {
      @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<BannerProductProvider>(context, listen: false)
            .clearData();
        Provider.of<BannerProductProvider>(context, listen: false)
            .getFirebaseData(widget.bannerdetails.bannerID, null);
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
         
          slivers: [
            const SliverAppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
      scrolledUnderElevation: 5,
      elevation: 10,
      pinned: true,
      backgroundColor: Colors.white,
        
      
      ),
                 SliverPadding(
         padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
         sliver: 
        Provider.of<BannerProductProvider>(
                        context,
                      ).isFirebaseDataLoding ==
                      false
                  ? Provider.of<BannerProductProvider>(
                      context,
                    ).productList.isNotEmpty
                      ? SliverGrid(
                  
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 10,mainAxisSpacing: 10,childAspectRatio:2/2 ),
                          delegate: SliverChildBuilderDelegate(
                            
                            childCount:  Provider.of<BannerProductProvider>(context).productList .length,
           
                            (context, index) {
                              return BannerProductFrame(productDetails:Provider.of<BannerProductProvider>(context).productList[index] ,
                              
                              remove: (){
                                customPoPup(context, "Remove",
                                 "This product can be removed from this banner.", (){
                                    FirebaseFirestore.instance.collection("products")
                                   .doc("${Provider.of<BannerProductProvider>(context, listen: false).productList[index].productID}").update(
                                      {
                                       "bannerID":null,
                                        }
                                       );
                                                     Provider.of<BannerProductProvider>(context,
                                            listen: false)
                                        .removeAt(index);

                                    /// last 12 ennam ayaalum and circularProgressLOading==true annegil veendum data get cheyyan
                                    List<ProductDetailsModel> productList =
                                        Provider.of<BannerProductProvider>(context,
                                                listen: false)
                                            .productList;
                                    if (productList.length <= 8 &&
                                        Provider.of<BannerProductProvider>(context,
                                                    listen: false)
                                                .circularProgressLOading ==
                                            true) {
                                      Provider.of<BannerProductProvider>(context,
                                              listen: false)
                                          .getFirebaseData(
                                              widget.bannerdetails.bannerID,
                                              productList.last.lastdoc);
                                    }
                                    //
                                    if (productList.isEmpty) {
                                      Provider.of<BannerProductProvider>(context,
                                              listen: false)
                                          .getFirebaseData(
                                              widget.bannerdetails.bannerID, null);
                                    }
                                       
                                       Navigator.pop(context);
                                 }, "OK");
                                 
                              });
                            },
                          ),): SliverToBoxAdapter(

                  child:     Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                     const Center(
                          child: Text("Products is empty...     ",style: TextStyle(
                            fontFamily: "pop",
                            color: Colors.black,
                          ),),
                        ),
                    ],
                  ),
                ):SliverToBoxAdapter(

                  child:     Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                     const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                    ],
                  ),
                ),
              
          
       
              
       ),
             SliverToBoxAdapter(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Provider.of<BannerProductProvider>(context).isFirebaseDataLoding ==
                          false
                  ? Provider.of<BannerProductProvider>(context)
                              .circularProgressLOading ==
                          true
                      ? Tooltip(
                          message: "Get the next list",
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 45,
                            width: 45,
                            child: MaterialButton(
                              elevation: 3,
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200))),
                              onPressed: () {
                                if (Provider.of<BannerProductProvider>(context,
                                            listen: false)
                                        .isNextListDataLoding ==
                                    false) {
                                  Provider.of<BannerProductProvider>(context,
                                          listen: false)
                                      .getFirebaseData(
                                    widget.bannerdetails.bannerID,
                                    Provider.of<BannerProductProvider>(context,
                                            listen: false)
                                        .productList
                                        .last
                                        .lastdoc,
                                  );
                                }
                              },
                              child: Provider.of<BannerProductProvider>(context)
                                          .isNextListDataLoding ==
                                      false
                                  ? const Icon(
                                      CupertinoIcons.add,
                                      color: Colors.black,
                                      size: 22,
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 8),
                                      child:  CupertinoActivityIndicator(),
                                    ),
                            ),
                          ),
                        )
                      : Container()
                  : Container(),
            ],
          )), 
          ],
       
      ),
    );
  }
}


