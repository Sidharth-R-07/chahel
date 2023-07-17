import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/product_details_model.dart';
import 'package:ecommerceadminweb/models/product_parameters_model.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

import 'shimmer.dart';


class OfferProductFrame extends StatefulWidget {
  const OfferProductFrame({super.key,required this.productDetails,required this.remove,});
  final ProductDetailsModel productDetails;
  final Function remove;
  


  @override
  State<OfferProductFrame> createState() => _OfferProductFrameState();
}

class _OfferProductFrameState extends State<OfferProductFrame> {
  List<ProductParametersModel> stockoutList=[]; 
   AssetImage  stockoutimage=const AssetImage("images/stockout.png");
   String selectedUnit="";

  @override
  Widget build(BuildContext context) {
    getStockoutResult();
    return Stack(
                        fit: StackFit.expand,
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            shape:const RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ClipRRect(
                              borderRadius:const BorderRadius.all(Radius.circular(10)),
                              child:CachedNetworkImage(
                imageUrl: widget.productDetails.image[0],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const CustomShimmer(
                  radius: 10,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
                 
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:const BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                 begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                colors: [
                                 
                                Colors.transparent, Colors.black.withOpacity(0.4),
                              ])
                            ),
                          ),
                              Padding(
                padding: const EdgeInsets.only(left: 5, right: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
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
                          if (value == 0) {
                             widget.remove.call();
                          }
                        }),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                           
                            value: 0,
                            // row has two child icon and text
                            child: Row(
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(
                                  // sized box with width 10
                                  width: 10,
                                ),
                                Text("Remove"),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "${widget.productDetails.name}",
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
                    
                    const SizedBox(
                      height: 15,
                    ),
                    stockoutList.isNotEmpty?
                         Padding(
                           padding: const EdgeInsets.only(right:5.0,bottom: 5),
                           child: SizedBox(
                            height: MediaQuery.of(context).size.height/25,
                            width: MediaQuery.of(context).size.width/25,
                             child: PopupMenuButton<String>(
                              iconSize: 35,
                             tooltip: "Stock out",
                         itemBuilder: (context) =>
                         stockoutList.map((item) =>
                          PopupMenuItem<String>(child: Text("${item.uint}, is out of stock",style:const TextStyle(
                              fontSize: 14,fontFamily: "pop",
                              color: Colors.red
                          ))
                          ,),).toList(),
                          child: Image(image: stockoutimage,),
                          onSelected: (value) {
                              selectedUnit=value;
                          },
                          onCanceled: () {
                             
                              erroetoast("Sorry, if you want to edit the stock you have to go to the stock page");
                          },
                          ),
                           ),
                         )
                    :Container(),
                  ],
                ),
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