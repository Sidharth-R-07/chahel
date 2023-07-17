import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/provider/offer_product_provider.dart';

import 'package:ecommerceadminweb/screens/offer_products_add_screen.dart';
import 'package:ecommerceadminweb/widgets/custom_popup.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:ecommerceadminweb/widgets/offer_product_frame.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_details_model.dart';

class OfferProductDisplayScreen extends StatefulWidget {
  const OfferProductDisplayScreen({super.key, required this.offerElementID});
  final String offerElementID;

  @override
  State<OfferProductDisplayScreen> createState() =>
      _OfferProductDisplayScreenState();
}

class _OfferProductDisplayScreenState extends State<OfferProductDisplayScreen> {
  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<OfferProductProvider>(context, listen: false)
            .clearData();
        Provider.of<OfferProductProvider>(context, listen: false)
            .getFirebaseData(widget.offerElementID, null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
         const SliverAppBar(
            iconTheme:  IconThemeData(
              color: Colors.black,
            ),
            scrolledUnderElevation: 5,
            elevation: 10,
            pinned: true,
            backgroundColor: Colors.white,
         
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              sliver:Provider.of<OfferProductProvider>(
                        context,
                      ).isFirebaseDataLoding ==
                      false
                  ? Provider.of<OfferProductProvider>(
                      context,
                    ).productList.isNotEmpty
                      ?SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                    
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 2 / 2),
                              delegate: SliverChildBuilderDelegate(
                                childCount: Provider.of<OfferProductProvider>(context).productList.length,
                                (context, index) {
                                  return OfferProductFrame(
                                      productDetails: Provider.of<OfferProductProvider>(context).productList[index],
                                      remove: () {
                                        customPoPup(context, "Remove",
                                            "This product can be removed from this offer.",
                                            () {
                                          FirebaseFirestore.instance
                                              .collection("products")
                                              .doc(
                                                  "${Provider.of<OfferProductProvider>(context,listen: false).productList[index].productID}")
                                              .update({
                                            "offerID": null,
                                          });
                                           Provider.of<OfferProductProvider>(context,
                                            listen: false)
                                        .removeAt(index);

                                    /// last 12 ennam ayaalum and circularProgressLOading==true annegil veendum data get cheyyan
                                    List<ProductDetailsModel> productList =
                                        Provider.of<OfferProductProvider>(context,
                                                listen: false)
                                            .productList;
                                    if (productList.length <= 8 &&
                                        Provider.of<OfferProductProvider>(context,
                                                    listen: false)
                                                .circularProgressLOading ==
                                            true) {
                                      Provider.of<OfferProductProvider>(context,
                                              listen: false)
                                          .getFirebaseData(
                                              widget.offerElementID,
                                              productList.last.lastdoc);
                                    }
                                    //
                                    if (productList.isEmpty) {
                                      Provider.of<OfferProductProvider>(context,
                                              listen: false)
                                          .getFirebaseData(
                                              widget.offerElementID, null);
                                    }
                                          Navigator.pop(context);
                                        }, "OK");
                                      });
                                },
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        2.5,
                                  ),
                                  const Center(
                                    child: Text(
                                      "Products is empty...     ",
                                      style: TextStyle(
                                        fontFamily: "pop",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):

SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                            ),
                            const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ],
                        ),
                      ),),
             
                   SliverToBoxAdapter(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Provider.of<OfferProductProvider>(context).isFirebaseDataLoding ==
                          false
                  ? Provider.of<OfferProductProvider>(context)
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
                                if (Provider.of<OfferProductProvider>(context,
                                            listen: false)
                                        .isNextListDataLoding ==
                                    false) {
                                  Provider.of<OfferProductProvider>(context,
                                          listen: false)
                                      .getFirebaseData(
                                    widget.offerElementID,
                                    Provider.of<OfferProductProvider>(context,
                                            listen: false)
                                        .productList
                                        .last
                                        .lastdoc,
                                  );
                                }
                              },
                              child: Provider.of<OfferProductProvider>(context)
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
                                      child:CupertinoActivityIndicator(),
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






