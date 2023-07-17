import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';






class ProductUnitProvider extends ChangeNotifier{
List <String>productunitList=[];
bool isFirebaseLoding=false;


Future<void> getUnitsFirebase()async{

  try {
  isFirebaseLoding=true;
  notifyListeners();
  // var event=await
    FirebaseFirestore.instance.collection("general").doc("units").snapshots().listen((event) {
       productunitList=[];
      for (var element in event["unitList"]??[]) {
         productunitList.insert(0,element);
         log(element);
      } 
     isFirebaseLoding=false;
     
   notifyListeners();
   });
} on Exception catch (e) {
  log(e.toString());
}

   
  
 
}

void addunit(context,String? unitname){

  if (unitname!=null&&unitname!=""&&unitname!=" ") {
  productunitList.add(unitname);
  FirebaseFirestore.instance.collection("general").doc("units").set(
    {
      "unitList":productunitList,
    }
  );
   Navigator.pop(context);
}else{
  erroetoast("Please add unit name");
}
}






}