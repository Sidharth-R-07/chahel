import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future tickPoPup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (context,setState) {
            return CupertinoAlertDialog(
       
              title:const  Text("Order delivered",style: TextStyle(
                fontFamily: "pop",
               
                fontWeight: FontWeight.w900,
              ),),
              content: Column(
                children: const[
                  SizedBox(height: 10,),
                  Icon(Icons.task_alt_sharp,size: 80, color: Colors.green,),
                ],
              ),
              actions: <Widget>[
                CupertinoButton(child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.blue),
                  ),
                 onPressed: (){
                  Navigator.pop(context);
                 }),]);
                
            
          }
        );
      });
}
