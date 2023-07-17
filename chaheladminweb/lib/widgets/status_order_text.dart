import 'package:ecommerceadminweb/Enums/order_enum.dart';
import 'package:flutter/material.dart';


class StatusOrderText extends StatelessWidget {
  const StatusOrderText({super.key,required this.orderenum});
  final Orderenum orderenum;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:const EdgeInsets.only(left: 90),
      padding:const EdgeInsets.symmetric(horizontal: 10),
      
    
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 10,width: 10,decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(100),),
            color:orderenum==Orderenum.pending?const Color(0XFFF3A638):
            orderenum==Orderenum.accepted?Colors.teal:
              orderenum==Orderenum.packed? Colors.lightGreen:
              orderenum==Orderenum.shipped?const Color(0XFF1E91CF):
              orderenum==Orderenum.delivered?const Color(0XFF4CB64C):
              orderenum==Orderenum.other?Colors.red:
              Colors.white,

          ),),
         const SizedBox(width: 5,),
          Text(orderenum==Orderenum.pending?"Pending"
                  :orderenum==Orderenum.accepted?"Accepted":
                  orderenum==Orderenum.packed?"Packed":
                   orderenum==Orderenum.shipped?"Shipped":
                   orderenum==Orderenum.delivered?"Delivered":
                   orderenum==Orderenum.other?"Rejected":
                   "",style:const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "pop",
                   ),
          
          ),
        ],
      ),
    );
  }
}