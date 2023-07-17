import 'package:ecommerceadminweb/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_type.dart';
import 'status_order_text.dart';


class OrderFrame extends StatelessWidget {
  const OrderFrame({super.key,required this.orderDetails});
  final OrderModel orderDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
                            children: [
                              Container(
                                color: Colors.white,
                                 
                                height: 70,
                                child: Row(
                                  children: [



                                   //ORDER CODE
                                    Container(
                                      padding:const EdgeInsets.symmetric(horizontal: 10),
                                      
                                      width: 170,
                                      child: Text(orderDetails.orderID,style:const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),),),
                                        //DATE
                                       Container(
                                      padding:const EdgeInsets.symmetric(horizontal: 10),
                                      
                                      width: 180,
                                      child: Text(DateFormat('MM/dd/yyyy, hh:mm a').format(orderDetails.ordertime.toDate()),style:const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),)),
                                       //NAME
                                        Container(
                                      padding:const EdgeInsets.symmetric(horizontal: 10),
                                     
                                      width: 300,
                                      child: Text("${orderDetails.userDetails.name}  [${orderDetails.userDetails.phoneNumber}]",style:const TextStyle(
                                        color: Colors.black,
                                        //fontFamily: "pop",
                                        //fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        
                                      ),maxLines: 2,)),
                                      //items
                                        Container(
                                      padding:const EdgeInsets.symmetric(horizontal: 10),
                                     
                                      width: 150,
                                      child: Text(orderDetails.productList.length.toString(),style:const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis
                                      ),maxLines: 2,)),
                                      
                                      //PaymentType
                                      PaymentType(isOnlinePayment: orderDetails.isonlinepayment),
                                     //StatusOrderText
                                      StatusOrderText(orderenum:orderDetails.ordertracking),
                                      
                                    //Amount
                                          Expanded(
                                            child: Container(
                                         
                                                                                padding:const EdgeInsets.symmetric(horizontal: 10),
                                                                               
                                                                            
                                                                                child: Text("₹${orderDetails.amount}",style:const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily: "pop",
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: 15
                                                                                ),maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,)),
                                          ),
                                       const   SizedBox(width: 25,),
                                  ],
                                ),
                              ),
                             Container(
                              height: 1,
                              color: Colors.grey.shade700,
                             ),
                            ],
                          );
  }
}