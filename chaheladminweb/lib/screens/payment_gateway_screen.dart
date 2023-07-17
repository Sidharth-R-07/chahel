import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../general/app_colors.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_toast.dart';
import '../widgets/shift_button.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({super.key});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  TextEditingController gatewayEditingController = TextEditingController();
  bool onlinepayment=false;
  bool cashondelivery=false;
  bool isFirebaseLoading=true;
  bool isdispose=false;
  
  @override
  void initState() {
    paymentMethodData();
    super.initState();
  }
  @override
  void dispose() {
    isdispose=true;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          title:const Text(
                "Payment type",
                style: TextStyle(
                  fontFamily: "pop",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
        Container(
          width: 1000,
          height: 350,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child:isFirebaseLoading==false? ListView(
            children: [
                        const Text(
                            "Razorpay payment gateway is the current one and must add live key only."),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomTextfield(
                            controller: gatewayEditingController,
                            labelText: "Enter razorpay gateway key",
                            
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                          
                            InkWell(
                          onTap: (){
                               
                          if (onlinepayment) {
                               onlinepayment=false;
                             }else{
                              if(gatewayEditingController.text.isNotEmpty){
                                onlinepayment=true;
                              }else{
                                erroetoast("Please add razorpay gateway key");
                              }
                               
                             }
                             setState(() {
                               
                             });

            
                          },
                          child: ShiftButton(shift: onlinepayment)),   
                    

                      const SizedBox(width: 10,),
  const Text("Online payment",
  style: TextStyle(
                              fontFamily: "pop",
                            ),),
                          ],
                        ),
                         const SizedBox(
                          height: 20,
                        ),

                        Row(
                          children: [
                      InkWell(
                          onTap: (){
                               if (cashondelivery) {
                                  cashondelivery=false;
                                }else{
                                  cashondelivery=true;
                                }
                                setState(() {
                                  
                                });
                          },
                          child: ShiftButton(shift: cashondelivery)),                   
                     
                          const SizedBox(width: 10,), const Text("Cash on Delivery",style: TextStyle(
                              fontFamily: "pop",
                            ),),
                          ],
                        ),
                         const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              color: uploadButtonColors,
                              height: 50,
                              onPressed: () {
                               
                                  FirebaseFirestore.instance.collection("general").doc("payment").set({
                                    "razorpay": gatewayEditingController.text,
                                    "onlinepayment":onlinepayment,
                                    "cashondelivery":cashondelivery,
                                  });
                                  saccesstoast(
                                      "Payment gateway key added successfully.");
                           
                              },
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  fontFamily: "pop",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
          ):const Center(child: CupertinoActivityIndicator()),
        ),
      ],
    );
  }

  
  void paymentMethodData(){
    
    isFirebaseLoading=true;
    if (isdispose==false) {
    setState(() {
      
    });  
    }
    
      FirebaseFirestore.instance.collection("general").doc("payment").snapshots().listen((event) { 
         onlinepayment=event.data()?["onlinepayment"]??false;
         cashondelivery=event.data()?["cashondelivery"]??false;
         gatewayEditingController.text=event.data()?["razorpay"]??"";
       isFirebaseLoading=false;
       if (isdispose==false) {
    setState(() {
      
    });  
    }
      });
              
              

   
  }    
}
