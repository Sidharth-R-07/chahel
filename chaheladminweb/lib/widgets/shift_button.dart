import 'package:flutter/material.dart';


class ShiftButton extends StatelessWidget {
  const ShiftButton({super.key,required this.shift});
  final bool shift;
 

  @override
  Widget build(BuildContext context) {
    return  Row(
      
      children: [
        Container(
          padding:const EdgeInsets.symmetric(horizontal:4,vertical: 2),
          height: 30,
          width: 60,
          decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(50)),
            color: shift?Colors.blue:Colors.grey.shade200,
          ),
          child: Row(
            mainAxisAlignment: shift?MainAxisAlignment.end:MainAxisAlignment.start,
            children: [
              Container(height: 25,width: 25, decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(50)),
            color: shift==false?Colors.blue:Colors.white,
          ),),
              
            ],
          ),
        ),
      ],
    );
  }
}