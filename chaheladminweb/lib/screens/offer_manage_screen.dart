import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/offer_model.dart';
import '../widgets/shimmer.dart';
import 'offer_product_display_screen.dart';
import 'offer_products_add_screen.dart';

void manageofferScreen (context,OfferModel offerDetails) {
    
  showDialog(
     
      context: context,
      builder: (context) {

      
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            
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
                  "Manage offer.",
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    //1
                    Stack(

                      children: [

                        Card(
                          elevation: 5,
                          child: Container(
                              padding: EdgeInsets.zero,
                              height: 300,
                              width: 200,
                              color: Colors.white,
                              child:CachedNetworkImage(
                                    imageUrl: offerDetails.offerAndIdList[0].image,
                                    width: 200,fit: BoxFit.cover,
                                    placeholder: (context, url) => 
                               const  CustomShimmer(),
                                    errorWidget: (context, url, error) =>const Icon(Icons.error),
                                ), ),
                        ),
                        OfferPopupMenuButton(offerElementID: offerDetails.offerAndIdList[0].iD),
                      ],
                    ),
                    // 2
                         Stack(
                           children: [
                             Card(
                               elevation: 5,
                               child: Container(
                                   padding: EdgeInsets.zero,
                                   height: 300,
                                   width: 200,
                                   color: Colors.white,
                                   child: CachedNetworkImage(
                                             imageUrl: offerDetails.offerAndIdList[1].image,
                                             width: 200,fit: BoxFit.cover,
                                             placeholder: (context, url) => 
                                        const  CustomShimmer(),
                                             errorWidget: (context, url, error) =>const Icon(Icons.error),
                                         ),),
                             ),
                              OfferPopupMenuButton(offerElementID: offerDetails.offerAndIdList[1].iD)
                           ],
                         ),
                //3
                     Stack(
                       children: [
                         Card(
                           elevation: 5,
                           child: Container(
                               padding: EdgeInsets.zero,
                               height: 300,
                               width: 200,
                               color: Colors.white,
                               child: CachedNetworkImage(
                                         imageUrl: offerDetails.offerAndIdList[2].image,
                                         width: 200,fit: BoxFit.cover,
                                         placeholder: (context, url) => 
                                    const  CustomShimmer(),
                                         errorWidget: (context, url, error) =>const Icon(Icons.error),
                                     ),),
                         ),
                          OfferPopupMenuButton(offerElementID: offerDetails.offerAndIdList[2].iD)
                       ],
                     ),
                //4
                     Stack(
                       children: [
                         Card(
                           elevation: 5,
                           child: Container(
                               padding: EdgeInsets.zero,
                               height: 300,
                               width: 200,
                               color: Colors.white,
                               child:CachedNetworkImage(
                                         imageUrl: offerDetails.offerAndIdList[3].image,
                                         width: 200,fit: BoxFit.cover,
                                         placeholder: (context, url) => 
                                    const  CustomShimmer(),
                                         errorWidget: (context, url, error) =>const Icon(Icons.error),
                                     ),),
                         ),
                          OfferPopupMenuButton(offerElementID: offerDetails.offerAndIdList[3].iD)
                       ],
                     ),
                  ],
                ),
              ),
            ),
          );
        });
      });
}





class OfferPopupMenuButton extends StatelessWidget {
  const OfferPopupMenuButton({super.key,required this.offerElementID});
  final String offerElementID;

  @override
  Widget build(BuildContext context) {
    return  Card(
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
                                   showDialogAddofferProducts(context, offerElementID);
                                    }else if(value == 1) {
                                       Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return OfferProductDisplayScreen(offerElementID: offerElementID);
                                     },),);
                                    }
                                  }),
                                  itemBuilder: (context) => [
                                       PopupMenuItem(
                                      value: 0, //---add this line
                              
                                      // row has two child icon and text
                                      child: Row(
                                        children: const [
                                          Icon(Icons.add_circle_outline),
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
                                    
                                  ],
                                  //  offset: Offset(0, 100),
                                  color: Colors.white,
                                  elevation: 5,
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              );
  }
}
