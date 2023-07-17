import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/models/banner_model.dart';
import 'package:ecommerceadminweb/provider/banner_search_product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/shimmer.dart';

void showDialogAddBannerProducts(context,BannerModel bannerDetail) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        TextEditingController searchController = TextEditingController();
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
                      "Add product.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "pop",
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                content: SizedBox(
                 height: 500,
                 width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 1,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.search,
                                        color: appcolor1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 30,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: (value) {
                                          Provider.of<BannerSearchProductProvider>(context,listen: false).getSearchProduct(value,
                                          );
                 
                                        },
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 15, left: 10, right: 5),
                                            border: InputBorder.none),
                                      )),
                                  Container(
                                    height: 20,
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      searchController.clear();
                                      setState(() {});
                                      Provider.of<BannerSearchProductProvider>(
                                              context,
                                              listen: false)
                                          .clearData();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: appcolor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Provider.of<BannerSearchProductProvider>( context,
                                             
                                             ).isFirebaseDataLoding==false? 
                            Provider.of<BannerSearchProductProvider>( context,
                                             
                                             ).productList.isNotEmpty?
                                             GridView.builder(
                            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3/2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,

                            ),

                            itemCount:  Provider.of<BannerSearchProductProvider>( context,
                                             
                                             ).productList.length ,
                            itemBuilder: (context, index) {
                             return      Card(
                            margin: EdgeInsets.zero,
                            shape:const RoundedRectangleBorder(
                               borderRadius: BorderRadius.zero,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.topRight,
                                children: [
                                  CachedNetworkImage(
                                  imageUrl:  Provider.of<BannerSearchProductProvider>(context,listen: false).productList[index].image[0],
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      const CustomShimmer(
                                    //radius: 10,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                                                              Container(
                            decoration: BoxDecoration(
                             
                              gradient: LinearGradient(
                                 begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                colors: [
                                 
                                Colors.transparent, Colors.black.withOpacity(0.4),
                              ])
                            ),
                          ),
                                                                Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "  ${Provider.of<BannerSearchProductProvider>(context,).productList[index].name}",
                            style: TextStyle(
                              fontFamily: "pop",
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width/100,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                             Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                             children: [
                            Checkbox(value: (Provider.of<BannerSearchProductProvider>(context,listen: false).productList[index].bannerID??false)==bannerDetail.bannerID,
                             onChanged: (value){
                          if (value==true) {
                            FirebaseFirestore.instance.collection("products")
                            .doc("${Provider.of<BannerSearchProductProvider>(context,listen: false)
                           .productList[index].productID}").update(
                            {
                            "bannerID":bannerDetail.bannerID,
                                }
                               );
                              Provider.of<BannerSearchProductProvider>(context,listen: false).productList[index].bannerID=bannerDetail.bannerID;
                              Provider.of<BannerSearchProductProvider>(context,listen: false).localsetState();
                             }else{
                            FirebaseFirestore.instance.collection("products")
                          .doc("${Provider.of<BannerSearchProductProvider>(context,listen: false)
                         .productList[index].productID}").update(
                        {
                          "bannerID":null,
                          }
                            );
                       Provider.of<BannerSearchProductProvider>(context,listen: false).productList[index].bannerID=null;
                      Provider.of<BannerSearchProductProvider>(context,listen: false).localsetState();
                      }
                                                        
                 
                       }),
                     ],
                            ),
                                ],
                              ),
                            ),
                          );
                          },):
                             Center(
                          child: Text(searchController.text.isEmpty?"Search products...     ":'No results found for "${searchController.text}" ',style:const TextStyle(
                            fontFamily: "pop",
                            color: Colors.black,
                          ),),
                        )
                          :Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const [
                              CupertinoActivityIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    color: Colors.white.withOpacity(.3),
                    child: IconButton(
                      onPressed: () {
                          searchController.clear();
                                      setState(() {});
                                      Provider.of<BannerSearchProductProvider>(
                                              context,
                                              listen: false)
                                          .clearData();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      });
}
