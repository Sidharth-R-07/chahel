import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/banner_model.dart';
import 'package:flutter/material.dart';

import 'shimmer.dart';


class BannerFrame extends StatelessWidget {
  const BannerFrame({super.key ,required this.bannerDetails,required this.delete,required this.edit,required this.addProducts,required this.viewproducts});
 final BannerModel bannerDetails;
 final Function edit;
  final Function delete;
  final Function addProducts;
  final Function viewproducts;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topRight,
      children: [
        Card(
          elevation: 2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CachedNetworkImage(
                imageUrl: bannerDetails.image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const CustomShimmer(
                  radius: 10,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
          ),
        ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                            elevation: 0,
                            shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            color: Colors.black.withOpacity(.1),
                            child: PopupMenuButton<int>(
                              shape:const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20),),
                              ),
                              onSelected: ((value) {
                               
                                if (value==0){
                                 addProducts.call();
                                } else if (value==1){
                                 viewproducts.call();
                                } else if(value == 2) {
                                 edit.call();
                                }else{
                                  delete.call();
                                 
                                }
                              }),
                              itemBuilder: (context) => [
                                     PopupMenuItem(
                                  value: 0, //---add this line
                          
                                  // row has two child icon and text
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add_circle_outline_outlined),
                                      SizedBox(
                                        // sized box with width 10
                                        width: 10,
                                      ),
                                      Text("Add products")
                                    ],
                                  ),
                                ),
                                 PopupMenuItem(
                                  value: 1, //---add this line
                          
                                  // row has two child icon and text
                                  child: Row(
                                    children: const [
                                      Icon(Icons.grid_view_outlined),
                                      SizedBox(
                                        // sized box with width 10
                                        width: 10,
                                      ),
                                      Text("View products")
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2, //---add this line
                          
                                  // row has two child icon and text
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        // sized box with width 10
                                        width: 10,
                                      ),
                                      Text("Edit")
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                 
                                  value: 3,
                                  // row has two child icon and text
                                  child: Row(
                                    children: const [
                                      Icon(Icons.delete),
                                      SizedBox(
                                        // sized box with width 10
                                        width: 10,
                                      ),
                                      Text("Delete"),
                                    ],
                                  ),
                                ),
                              ],
                              //  offset: Offset(0, 100),
                              color: Colors.white,
                              elevation: 5,
                              icon: const Icon(
                                Icons.more_vert_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
      ],
    );
  }
}