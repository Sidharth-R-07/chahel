import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/offer_model.dart';
import 'package:flutter/material.dart';

import '../screens/offer_product_display_screen.dart';
import 'shimmer.dart';

class OfferFrame extends StatelessWidget {
  const OfferFrame(
      {super.key,
      required this.offerDetails,
      required this.delete,
      required this.edit,
      required this.manageoffer});
  final OfferModel offerDetails;
  final Function edit;
  final Function delete;
  final Function manageoffer;
  
  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
           
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OfferProductDisplayScreen(
                                    offerElementID: offerDetails.offerAndIdList[0].iD);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: CachedNetworkImage(
                                imageUrl: offerDetails.offerAndIdList[0].image,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const CustomShimmer(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                         onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OfferProductDisplayScreen(
                                    offerElementID: offerDetails.offerAndIdList[1].iD);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: CachedNetworkImage(
                                imageUrl: offerDetails.offerAndIdList[1].image,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const CustomShimmer(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                         onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OfferProductDisplayScreen(
                                     offerElementID: offerDetails.offerAndIdList[2].iD);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: CachedNetworkImage(
                                imageUrl: offerDetails.offerAndIdList[2].image,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const CustomShimmer(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                         onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OfferProductDisplayScreen(
                                     offerElementID: offerDetails.offerAndIdList[3].iD);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: CachedNetworkImage(
                                imageUrl: offerDetails.offerAndIdList[3].image,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const CustomShimmer(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
                          Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
     
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:5.0,right: 5),
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
                                     if(value == 0) {
                                     manageoffer.call();
                                    }else if(value == 1) {
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
                                          Icon(Icons.manage_search),
                                          SizedBox(
                                            // sized box with width 10
                                            width: 10,
                                          ),
                                          Text("Manage offer")
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1, //---add this line
                              
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
                                     
                                      value: 2,
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
                 Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "  ${offerDetails.name}",
                                style: TextStyle(
                                  fontFamily: "pop",
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.width/100,
                                  fontWeight: FontWeight.w800,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            offerDetails.designNumber==2?
                            const Icon(Icons.view_array_outlined,color: Colors.black,):
                            const  Icon(Icons.grid_view,color: Colors.black,size: 22,),
                          ],
                        ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}







