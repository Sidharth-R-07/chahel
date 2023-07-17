
import 'dart:developer';
import 'dart:typed_data';

import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class CustomPickImageProvider extends ChangeNotifier{
   
   Future<Uint8List?> pickimage() async {

    try {
      Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();

    if (bytesFromPicker == null)return null; 

     if ((bytesFromPicker.lengthInBytes / 1024).round() <= 199) {
    
                      
        return bytesFromPicker;                  
     }else{
       erroetoast("this image size: ${filesize(bytesFromPicker.lengthInBytes.toString())} / Max file size allowed is 200 kb");
      return null;
     }
     
     } catch (e) {
       log("$e pick image error");
     }
    return null;
  }
}



