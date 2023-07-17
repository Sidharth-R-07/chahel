import 'package:flutter/material.dart';


class CustomProductTextfield extends StatelessWidget {
  const CustomProductTextfield({super.key,this.hintText,this.labelText,required this.controller,this.maxLines});
  final String? hintText;
  final String? labelText;
  final int?maxLines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(

      
           maxLines: maxLines ?? 1,
        controller:controller ,
        
                            decoration: InputDecoration(
                              contentPadding:const EdgeInsets.only(top: 20,left: 10,right: 5),
                              focusedBorder: const OutlineInputBorder(
                                
                                borderRadius: BorderRadius.zero,
                                
                                  borderSide: BorderSide(
                                   width: 0.5,
                                   color: Color.fromARGB(255, 3, 48, 85),
                                   
                                  ),
                                ),
                                border:const OutlineInputBorder(
                                   borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                   width: 0.3
                                  ),
                                ),
                                hintText: hintText??"",
                                labelText: labelText??""
                                
                                ),
                          ),
    );
  }
}