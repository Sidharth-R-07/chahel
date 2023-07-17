import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/order_model.dart';
import 'package:ecommerceadminweb/widgets/shimmer.dart';
import 'package:flutter/material.dart';

import 'veg_or_nonveg.dart';

class OrderProductFrame extends StatelessWidget {
  const OrderProductFrame({super.key, required this.orderProductDetailes});
  final OrderProductsModel orderProductDetailes;

  @override
  Widget build(BuildContext context) {
   
    return Container(
      padding:const EdgeInsets.all(20),
      width: 800,
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: 125,
            width: 125,
            padding:const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300,
              
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: orderProductDetailes.image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const CustomShimmer(radius: 5),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 120,
              width: 120,
            ),
          ),
         const SizedBox(width: 10,),
         Expanded(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(orderProductDetailes.name,style:const TextStyle(
                    fontFamily: "pop",
                    fontWeight: FontWeight.w600,
                   ),),
                   //
                   orderProductDetailes.productType!=null?
                   VEGorNONVEG(isVEG: orderProductDetailes.productType, isText: false,size:17 )
                  :const SizedBox(),
                 ],
               ),
               const SizedBox(height: 5,),
                Text("Size: ${orderProductDetailes.unit}",style: TextStyle(
                fontFamily: "pop",
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
               ),),
               const SizedBox(height: 20,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Qty: ${orderProductDetailes.qty} × ₹${orderProductDetailes.rs}",style: TextStyle(
                    fontFamily: "pop",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                   ),),
                 const SizedBox(width: 10,),
                    Text(" ₹${(orderProductDetailes.qty*orderProductDetailes.rs)}",style:const TextStyle(
                    fontFamily: "pop",
                   // fontSize: 14,
                    fontWeight: FontWeight.w600,
                    //color: Colors.grey.shade700,
                   ),),
                 ],
               ),
               
             ],
           ),
         ),
        ],
      ),
    );
  }
}
