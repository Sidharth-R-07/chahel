import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/product_details_model.dart';
import 'package:ecommerceadminweb/models/product_parameters_model.dart';
import 'package:flutter/material.dart';

import 'shimmer.dart';

class ProductFrame extends StatefulWidget {
  const ProductFrame(
      {super.key,
      required this.productDetails,
      required this.delete,
      required this.edit});
  final ProductDetailsModel productDetails;
  final Function delete;
  final Function edit;

  @override
  State<ProductFrame> createState() => _ProductFrameState();
}

class _ProductFrameState extends State<ProductFrame> {
  List<ProductParametersModel> stockoutList = [];
  //AssetImage stockoutimage = const AssetImage("images/stockout.png");
  String selectedUnit = "";
  bool isStock=true;
  @override
  Widget build(BuildContext context) {
    getStockoutResult();
    return Column(
      children: [
        Container(
          height: 100,
          width: 1100,
          color: Colors.white,
          child: Row(
            
            children: [
             const SizedBox(width: 20,),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: widget.productDetails.image[0],
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const CustomShimmer(
                    radius: 10,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                 
                  height: 65,
                  width: 65,
                ),
              ),
             const SizedBox(width: 10,),
             SizedBox(
         
              width: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(widget.productDetails.name,style:const TextStyle(
                      fontFamily: "pop",
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis
                    ),),
                  ),
                 const SizedBox(height: 5,),
                 Flexible(
                   child: Text(widget.productDetails.description,style: TextStyle(
                      fontFamily: "pop",
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w300,
                      fontSize: 11,
                      overflow: TextOverflow.ellipsis
                      
                    ),maxLines: 2,),
                 )
                ],
              ),
             ),
             SizedBox(
             
              width: 285,
              child:  RichText(
                         textAlign: TextAlign.left,
                           text: TextSpan(
                               // text: "By continuing you agree to $appname's",
                               children: [
                                   TextSpan(
                                     text: "₹${widget.productDetails.productParameters?[0].rs}  ",style:const TextStyle(
                                     fontFamily: "pop",
                                     fontWeight: FontWeight.w600,
                                     
                                     color: Colors.black
                                   ),
                                 ),
                                    TextSpan(
                                     text: "₹${widget.productDetails.productParameters?[0].mrp}",style:const TextStyle(
                                     fontFamily: "pop",
                                     fontWeight: FontWeight.w400,
                                     fontSize: 13,
                                     decorationThickness: 1,
                                     decoration:TextDecoration.lineThrough ,
                                     color: Colors.grey
                                   ),
                                 ),
                               ],),overflow: TextOverflow.ellipsis,),
             ),
             SizedBox(
              width: 200,
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                     color:stockoutList.isEmpty?const Color.fromARGB(255, 19, 202, 25):Colors.red,
                     borderRadius:const BorderRadius.all(Radius.circular(100),),
                    ),
                   
                  ),
                  const SizedBox(width: 5,),
                  Text(stockoutList.isEmpty?"In stock":"Out of stock",style:const TextStyle(
                    fontFamily: "pop",
                    color: Colors.black,
                  ),),
                ],
              ),
             
             ),
             const Spacer(),
             PopupMenuButton<int>(
                        shape:const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20),),
                        ),
                        onSelected: ((value) {
                          if (value == 0) {
                           widget.edit.call();
                          }else{
                            widget.delete.call();
                           
                          }
                        }),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0, //---add this line
                    
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
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 20,),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
   void getStockoutResult(){
     stockoutList=[];
     for (ProductParametersModel element in widget.productDetails.productParameters??[]) {
        if ((element.stock??0)==0) {
            stockoutList.add(
              ProductParametersModel(
                stock: element.stock,
                uint: element.uint,
                mrp: element.mrp,
                rs: element.rs
              ),
            );
          }
     }
     setState(() {
       
     });
 }
}

























// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ecommerceadminweb/models/product_details_model.dart';
// import 'package:ecommerceadminweb/models/product_parameters_model.dart';
// import 'package:ecommerceadminweb/widgets/custom_toast.dart';
// import 'package:flutter/material.dart';

// import 'shimmer.dart';


// class ProductFrame extends StatefulWidget {
//   const ProductFrame({super.key,required this.productDetails,required this.delete,required this.edit});
//   final ProductDetailsModel productDetails;
//   final Function delete;
//     final Function edit;


//   @override
//   State<ProductFrame> createState() => _ProductFrameState();
// }

// class _ProductFrameState extends State<ProductFrame> {
//   List<ProductParametersModel> stockoutList=[]; 
//    AssetImage  stockoutimage=const AssetImage("images/stockout.png");
//    String selectedUnit="";


//   @override
//   Widget build(BuildContext context) {
//    getStockoutResult();
//     return Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           Card(
//                             margin: EdgeInsets.zero,
//                             shape:const RoundedRectangleBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(10)),
//                             ),
              //               child: ClipRRect(
              //                 borderRadius:const BorderRadius.all(Radius.circular(10)),
              //                 child:  CachedNetworkImage(
              //   imageUrl: widget.productDetails.image?[0],
              //   progressIndicatorBuilder: (context, url, downloadProgress) =>
              //       const CustomShimmer(
              //     radius: 10,
              //   ),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              //   fit: BoxFit.cover,
              // ),
                 
              //               ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius:const BorderRadius.all(Radius.circular(10)),
//                               gradient: LinearGradient(
//                                  begin: Alignment.centerRight,
//                                     end: Alignment.centerLeft,
//                                 colors: [
                                 
//                                 Colors.transparent, Colors.black.withOpacity(0.4),
//                               ])
//                             ),
//                           ),
//                               Padding(
//                 padding: const EdgeInsets.only(left: 5, right: 0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Card(
//                       elevation: 0,
//                       shape:const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(100)),
//                       ),
//                       color: Colors.black.withOpacity(.1),
//                       child: PopupMenuButton<int>(
//                         shape:const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20),),
//                         ),
//                         onSelected: ((value) {
//                           if (value == 0) {
//                            widget.edit.call();
//                           }else{
//                             widget.delete.call();
                           
//                           }
//                         }),
//                         itemBuilder: (context) => [
//                           PopupMenuItem(
//                             value: 0, //---add this line
                    
//                             // row has two child icon and text
//                             child: Row(
//                               children: const [
//                                 Icon(Icons.edit),
//                                 SizedBox(
//                                   // sized box with width 10
//                                   width: 10,
//                                 ),
//                                 Text("Edit")
//                               ],
//                             ),
//                           ),
//                           PopupMenuItem(
                           
//                             value: 2,
//                             // row has two child icon and text
//                             child: Row(
//                               children: const [
//                                 Icon(Icons.delete),
//                                 SizedBox(
//                                   // sized box with width 10
//                                   width: 10,
//                                 ),
//                                 Text("Delete"),
//                               ],
//                             ),
//                           ),
//                         ],
//                         //  offset: Offset(0, 100),
//                         color: Colors.white,
//                         elevation: 5,
//                         icon: const Icon(
//                           Icons.more_vert_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "${widget.productDetails.name}",
//                             style: TextStyle(
//                               fontFamily: "pop",
//                               color: Colors.white,
//                               fontSize: MediaQuery.of(context).size.width/100,
//                               fontWeight: FontWeight.w800,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
                    
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     stockoutList.isNotEmpty?
//                          Padding(
//                            padding: const EdgeInsets.only(right:5.0,bottom: 5),
//                            child: SizedBox(
//                             height: MediaQuery.of(context).size.height/25,
//                             width: MediaQuery.of(context).size.width/25,
//                              child: PopupMenuButton<String>(
//                               iconSize: 35,
//                              tooltip: "Stock out",
//                          itemBuilder: (context) =>
//                          stockoutList.map((item) =>
//                           PopupMenuItem<String>(child: Text("${item.uint}, is out of stock",style:const TextStyle(
//                               fontSize: 14,fontFamily: "pop",
//                               color: Colors.red
//                           ))
//                           ,),).toList(),
//                           child: Image(image: stockoutimage,),
//                           onSelected: (value) {
//                               selectedUnit=value;
//                           },
//                           onCanceled: () {
//                               widget.edit.call();
//                               normeltoast("Edit stock");
//                           },
//                           ),
//                            ),
//                          )
//                     :Container(),
//                   ],
//                 ),
//               ),
//                         ],
//                       );
//   }
//   void getStockoutResult(){
//      stockoutList=[];
//      for (ProductParametersModel element in widget.productDetails.productParameters??[]) {
//         if ((element.stock??0)==0) {
//             stockoutList.add(
//               ProductParametersModel(
//                 stock: element.stock,
//                 uint: element.uint,
//                 mrp: element.mrp,
//                 rs: element.rs
//               ),
//             );
//           }
//      }
//      setState(() {
       
//      });
//  }
// }