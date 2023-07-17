import 'package:flutter/material.dart';


class PaymentType extends StatelessWidget {
  const PaymentType({super.key,required this.isOnlinePayment});
  final bool isOnlinePayment; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 15),
      padding:const EdgeInsets.symmetric(horizontal: 10),
      
      decoration: BoxDecoration(
        color:isOnlinePayment?Colors.green.shade50: Colors.orange.shade50,
        borderRadius:const BorderRadius.all(Radius.circular(5),),
      ),
      child: Text(isOnlinePayment?"PAID":"COD",style: TextStyle(
        fontFamily: "pop",
        fontWeight: FontWeight.w600,
        color:isOnlinePayment?Colors.green: Colors.deepOrange,
      ),),
    );
  }
}