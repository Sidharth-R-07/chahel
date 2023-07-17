



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future textfildPoPup(BuildContext context,String title, Function  onPressed,String onPressedTEXT) {
  return showDialog(
      context: context,
      builder: (context) {
        TextEditingController textEditingController=TextEditingController();
        bool isTapbutton=false;
        return StatefulBuilder(
          builder: (context,setState) {
            return CupertinoAlertDialog(
       
              title:  Text(title),
              content: Material(
                color: Colors.grey.shade200,
                shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child:  TextField(
                  controller: textEditingController,
                  maxLength: 200,
                  maxLines: 3,
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(borderSide:BorderSide.none ,borderRadius: BorderRadius.all(Radius.circular(10)))
                  ),
                ),
              ),
              actions: <Widget>[
                CupertinoButton(child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                 onPressed: (){
                  Navigator.pop(context);
                 }),
                
              CupertinoButton(child: isTapbutton==false? Text(
                    onPressedTEXT,
                    style:const TextStyle(color: Colors.blue),
                  ):const CupertinoActivityIndicator(),
                 onPressed: (){
                  if (textEditingController.text.isNotEmpty) {
                      isTapbutton=true;
                      setState(() {
                        
                      },);
                    }
                  onPressed.call(textEditingController.text);
                 })
              ],
            );
          }
        );
      });
}
