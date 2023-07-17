import 'package:ecommerceadminweb/provider/product_unit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void creatUnit(context){
  showDialog(
      context: context,
      builder: (context) {
        TextEditingController textEditingController =TextEditingController();
        return AlertDialog(
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20),),
          ),
          title:const  Text("Create unit."),
          content:  TextField(
            autofocus: true,
            controller: textEditingController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed:() {
               Provider.of<ProductUnitProvider>(context,listen: false).addunit(context,textEditingController.text);
             
              },
                
           
              child:const  Text(
                "Create",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      });
}