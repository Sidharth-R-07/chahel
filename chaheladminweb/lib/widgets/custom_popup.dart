

import 'package:flutter/material.dart';

Future customPoPup(BuildContext context,String title,String text, Function  onPressed,String onPressedTEXT) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20),),
          ),
          title:  Text(title),
          content:  Text(text),
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
                onPressed();
              },
                
           
              child:  Text(
                onPressedTEXT,
                style:const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      });
}
