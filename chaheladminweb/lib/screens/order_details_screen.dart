import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/order_model.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Enums/order_enum.dart';
import '../widgets/order_product_frame.dart';
import '../widgets/payment_type.dart';
import '../widgets/status_order_text.dart';
import '../widgets/textfild_popup.dart';
import '../widgets/tick_popup.dart';

class OrderetailScreen extends StatefulWidget {
  const OrderetailScreen({super.key, required this.orderDetails});
  final OrderModel orderDetails;

  @override
  State<OrderetailScreen> createState() => _OrderetailScreenState();
}

class _OrderetailScreenState extends State<OrderetailScreen> {
  bool isDispose = false;
  bool isCopyorderID = false;
  bool isChangeOrderStatusLoding = false;
  bool isChangeOrderStatus = false;
  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
  @override
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        Navigator.pop(context,isChangeOrderStatus);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            log("11");
           Navigator.pop(context,isChangeOrderStatus);
           log("22");
          }, icon:const Icon(Icons.arrow_back)),
          iconTheme: IconThemeData(
            color: Colors.grey.shade800,
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          title: Row(
            children: [
              Text(
                "Order details",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontFamily: "pop",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            widget.orderDetails.ordertracking!=Orderenum.other?
              widget.orderDetails.ordertracking!=Orderenum.delivered?
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width/2.25,),
                      MaterialButton(
                         minWidth: 150,
                          height: 45,
                        onPressed: ()async{
                        
                        await textfildPoPup(context, "Reason for rejection", (String value)async{
                            if (value.isNotEmpty) {
                              if (isChangeOrderStatusLoding==false) {
                              
                                isChangeOrderStatus=true;
                                isChangeOrderStatusLoding=true;
                                if (isDispose == false) {
                                    setState(() {});
                                }
                                widget.orderDetails.ordertracking=Orderenum.other;
                                await FirebaseFirestore.instance.collection("orders").doc(widget.orderDetails.orderDocmentID).update(
                                  {
                                    "ordertracking":404,//rejected code 404 
                                    "rejectreason":value,
                                    "orderchangetime":Timestamp.now(),
                                  }                                      
                              );
                              isChangeOrderStatusLoding=false;
                                if (isDispose == false) {
                                    setState(() {});
                                  }
                                                      
                                normeltoast("Order successfully rejected");
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                             }
                            }else{
                              erroetoast("Please explain the reason for refusal");
                            }
                                                                  
                    
                         }, "Reject");

                      


                        },
                      child:const Text("Reject",style: TextStyle(
                       fontFamily: "pop",
                           color: Colors.red,
                            fontWeight: FontWeight.w700,
                      ),),
                      ),
                      const SizedBox(width: 10,),
                       MaterialButton(
                          minWidth: 150,
                          height: 45,
                           color:widget.orderDetails.ordertracking ==Orderenum.pending?Colors.teal:
                            widget.orderDetails.ordertracking==Orderenum.accepted?Colors.lightGreen:
                            widget.orderDetails.ordertracking==Orderenum.packed? const Color(0XFF1E91CF):
                            widget.orderDetails.ordertracking==Orderenum.shipped?const Color(0XFF4CB64C):
                            //widget.orderDetails.ordertracking==Orderenum.delivered?const Color(0XFF4CB64C):
                            Colors.white,
                          onPressed: ()async{
                            isChangeOrderStatus=true;
                            if (isChangeOrderStatusLoding==false) {
                              isChangeOrderStatusLoding=true;
                              if (isDispose == false) {
                                              setState(() {});
                                }
                              int trackingValue=0;
                              if(widget.orderDetails.ordertracking==Orderenum.pending){
                                trackingValue=1;
                                widget.orderDetails.ordertracking=Orderenum.accepted;
                              }else if(widget.orderDetails.ordertracking==Orderenum.accepted){
                                trackingValue=2;
                                widget.orderDetails.ordertracking=Orderenum.packed; 
                              }else if(widget.orderDetails.ordertracking==Orderenum.packed){
                                trackingValue=3;
                                widget.orderDetails.ordertracking=Orderenum.shipped;
                              }else if(widget.orderDetails.ordertracking==Orderenum.shipped){
                                trackingValue=4;
                                widget.orderDetails.ordertracking=Orderenum.delivered;
                                tickPoPup(context);
                              }
                                                
                              await FirebaseFirestore.instance.collection("orders").doc(widget.orderDetails.orderDocmentID).update(
                                  {
                                  "ordertracking":trackingValue,
                                  "orderchangetime":Timestamp.now(),
                                  }
                                
                                );
                               isChangeOrderStatusLoding=false;
                              if (isDispose == false) {
                                    setState(() {});
                                }
                            }
                          },
                          child:isChangeOrderStatusLoding==false? Text(widget.orderDetails.ordertracking==Orderenum.pending?"Accepted"
                          :widget.orderDetails.ordertracking==Orderenum.accepted?"Packed":
                          widget.orderDetails.ordertracking==Orderenum.packed?"Shipped":
                          widget.orderDetails.ordertracking==Orderenum.shipped?"Delivered":
                         // widget.orderDetails.ordertracking==Orderenum.delivered?"Delivered":
                          "",style:const TextStyle(
                            fontFamily: "pop",
                           color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),):const CupertinoActivityIndicator(color: Colors.white,),
                        ),
                    ],
                  ),
                ),
              ):Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width/1.9,),
                  Row(
                    children:const [
                      Text("  Order delivered  ",style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16,
                      ),),
                       Icon(Icons.task_alt_sharp, color: Colors.green,size: 25,),
                    ],
                  )
                ],
              )
              :Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width/1.9,),
                  Row(
                    children:const [
                      Text("  Order rejected  ",style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16,
                      ),),
                       Icon(Icons.cancel_outlined, color: Colors.red,size: 25,),
                    ],
                  )
                ],
              )
            ],
          ),
      
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800,
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(left:20,top: 20,right: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5))),
                      width: 500,
                      //height: 200,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    " Order ID:  ${widget.orderDetails.orderID}",
                                    style: const TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Tooltip(
                                    message: "copy",
                                    child: InkWell(
                                      onTap: () async {
                                       
                                        isCopyorderID = true;
                                        if (isDispose == false) {
                                          setState(() {});
                                        }
                                        await Clipboard.setData(ClipboardData(
                                            text: widget.orderDetails.orderID));
    
                                             normeltoast("copy: ${widget.orderDetails.orderID}");
                                        await Future.delayed(
                                            const Duration(seconds: 2), () {
                                          isCopyorderID = false;
                                          if (isDispose == false) {
                                            setState(() {});
                                          }
                                        });
                                      },
                                      child: isCopyorderID
                                          ? const Icon(Icons.check_circle,
                                              color: Colors.green, size: 19)
                                          : const Icon(
                                              Icons.copy,
                                              size: 19,
                                              color: Colors.grey,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              StatusOrderText(orderenum:widget.orderDetails.ordertracking),
                            ],
                          ),
                          const SizedBox(height: 30,),
                           Row(
                             children: [
                               Text(DateFormat(' MM/dd/yyyy, hh:mm a').format(widget.orderDetails.ordertime.toDate()),style: TextStyle(
                                color: Colors.grey.shade800,
                               fontWeight: FontWeight.w500,
                                fontFamily: "pop"
                                ),),
                             ],
                           ),
                           const SizedBox(height: 30,),
                           Container(height: 1.5,
                           decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius:const BorderRadius.all(Radius.circular(100))
                           ),
                           ),
                           const SizedBox(height: 30,),
                           Row(
                             children: [
                               Text(" ${widget.orderDetails.productList.length} ITEM",style: TextStyle(
                                    color: Colors.grey.shade800,
                                   fontWeight: FontWeight.w500,
                                    fontFamily: "pop"
                                    ),),
                             ],
                           ),
                        ],
                      ),
                    ),
    
                  ),
                  SliverList(delegate: SliverChildBuilderDelegate(
                    childCount: widget.orderDetails.productList.length,
                    (context, index){
                    return OrderProductFrame(
                      orderProductDetailes: widget.orderDetails.productList[index],
                    );
                  }),),
                  SliverToBoxAdapter(
                    child: Container(
                       padding: const EdgeInsets.only(left:20,bottom: 20,right: 20),
                      width: 800,
                    decoration: const BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(5),
                     bottomRight: Radius.circular(5)),
                                             
                              ),
                    child: Column(
                      children: [
                           const SizedBox(height: 30,),
                           Container(height: 1.5,
                           decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius:const BorderRadius.all(Radius.circular(100))
                           ),
                           ),
                           const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(" Item Total",style: TextStyle(
                                    color: Colors.grey.shade800,
                                   fontWeight: FontWeight.w600,
                                    fontFamily: "pop"
                                    ),),
                              const  SizedBox(width: 10,),
                           Text(" ₹${itemTotal(widget.orderDetails.productList)}",style: TextStyle(
                              fontFamily: "pop",
                            // fontSize: 14,
                              fontWeight: FontWeight.w600,
                             color: Colors.grey.shade800,
                            ),),
                          ],
                        ),
                       const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(" Delivery",style: TextStyle(
                                    color: Colors.grey.shade800,
                                   fontWeight: FontWeight.w600,
                                    fontFamily: "pop"
                                    ),),
                          const  SizedBox(width: 10,),
                          (widget.orderDetails.shippingcharge??0)>0?
                           Text(" ₹${widget.orderDetails.shippingcharge}",style: TextStyle(
                              fontFamily: "pop",
                            // fontSize: 14,
                              fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                            ),):
                            const Text("FREE",style: TextStyle(
                              fontFamily: "pop",
                            // fontSize: 14,
                              fontWeight: FontWeight.w600,
                            color: Colors.green,
                            ),),
                          ],
                        ),
                        const  SizedBox(height: 30,),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(" Grand Total",style: TextStyle(
                                    color: Colors.black,
                                   fontWeight: FontWeight.w700,
                                    fontFamily: "pop",
                                    fontSize: 15,
                                    ),),
                              const  SizedBox(width: 10,),
                           Text(" ₹${(itemTotal(widget.orderDetails.productList)+(widget.orderDetails.shippingcharge??0))}",style:const TextStyle(
                              fontFamily: "pop",
                            // fontSize: 14,
                              fontWeight: FontWeight.w700,
                             color: Colors.black,
                             fontSize: 15,
                            ),),
                          ],
                        ),
                      ],
                    ),
                    ),
                  ),
                    const SliverToBoxAdapter(
                    child: SizedBox(height: 35,),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                    padding: const EdgeInsets.all(20),
                      width: 800,
                   
                    decoration:  BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(5)
                                             
                              ),
                      child: Column(
                        children: [
                           const SizedBox(height: 10,),
                        Row(
                          children:const [
                              Text(" Customer details",style: TextStyle(
                                        color: Colors.black,
                                       fontWeight: FontWeight.w700,
                                        fontFamily: "pop",
                                        fontSize: 18,
                                        ),),
                          ],
                        ),
                             const SizedBox(height: 20,),
                           Container(height: 1.5,
                           decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius:const BorderRadius.all(Radius.circular(100))
                           ),
                           ),
                           const SizedBox(height: 30,),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 330,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Name",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text(widget.orderDetails.userDetails.name,style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  //
                                 const SizedBox(height: 40,),
                                   const Text("Road Name / Area / Colony",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text("${widget.orderDetails.userDetails.roadname}",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  const SizedBox(height: 40,),
                                   const Text("City",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text("${widget.orderDetails.userDetails.city}",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  //
                                  const SizedBox(height: 40,),
                                   const Text("State",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text("${widget.orderDetails.userDetails.state}",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  const SizedBox(height: 40,),
                                         const Text("Address type",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),),
                                
                                  const SizedBox(height: 10,),
                                   Text((widget.orderDetails.userDetails.ishome??true)?"Home":"Work",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                ],
                              ),
                              ),
    
    ///
    ///
    ///
    ///
    
    
    
                              const SizedBox(width: 10,),
                               SizedBox(width: 330,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   const Text("Mobile",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  ),),
                                  const SizedBox(height: 10,),
                                  Text(widget.orderDetails.userDetails.phoneNumber,style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  //
                                   const SizedBox(height: 40,),
                                   const Text("House No / Building name",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text("${widget.orderDetails.userDetails.houseNoBuilding}",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  const SizedBox(height: 40,),
                                   const Text("Pincode",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text("${widget.orderDetails.userDetails.pincode}",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                  const SizedBox(height: 40,),
                                   const Text("Payment",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),),
                                  const SizedBox(height: 10,),
                                   Text(widget.orderDetails.isonlinepayment?"Online Payment":"Cash on Delivery",style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),),
                                ],
                              ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                             
                                   PaymentType(isOnlinePayment:widget.orderDetails.isonlinepayment),
                                ],
                              ),
                            ],
                           ),
                        ],
                      ),
                    ),
                  ),
                 const SliverToBoxAdapter(
                    child: SizedBox(height: 60,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  double itemTotal(List<OrderProductsModel> productList){
    double amount=0;
    for (var element in productList) {
       amount=amount+ (element.qty*element.rs);
    }
    return amount;
  }
}
