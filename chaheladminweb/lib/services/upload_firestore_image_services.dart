 import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';


Future<String?> uploadFirestoreImageServices(Uint8List image) async {
  try {
   log("1");

    log("2");
   //Blob imageBlob = Blob(image);
   
   FirebaseStorage storage = FirebaseStorage.instance;
   
   Reference storageRef = storage.ref().child('images/file').child('${Timestamp.now().microsecondsSinceEpoch}webp_image.webp');

        final value =await storageRef.putData(image,SettableMetadata(contentType: 'image/webp'),);
        return await value.ref.getDownloadURL();

    


  } catch (e) {
    erroetoast(e.toString());
    return null;
  }

  
}



  







// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerceadminweb/widgets/custom_toast.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';

// Future<String?> uploadFirestoreImageServices(Uint8List image) async {
//   try {
//     var storage = FirebaseStorage.instance;
    // Reference ref = storage.ref().child('${Timestamp.now().microsecondsSinceEpoch}.jpeg');
    // final value =await ref.putData(image,SettableMetadata(contentType: 'image/jpeg'),);
    //     return await value.ref.getDownloadURL();
          
      
    

//   } catch (e) {
//     erroetoast(e.toString());
//     return null;
//   }

  
// }
