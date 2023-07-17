
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/product_details_model.dart';
import 'package:ecommerceadminweb/services/products_docs_get_model.dart';
import 'package:flutter/cupertino.dart';

class BannerSearchProductProvider extends ChangeNotifier{
  List<ProductDetailsModel> productList = [];
  bool isFirebaseDataLoding = false;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  // bool dataLODING = false; //firebase data loading condition variable
  bool? productloading = false;
  bool? circularProgressLOading =
      true; //data loading bottom circularProgress condition variable
  

   void clearData(){
    lastdoc=null;
    productList=[];
    isFirebaseDataLoding = false;
    productloading = false;
    circularProgressLOading =true; //data loading bottom circularProgress condition variable
      
     notifyListeners();
  }


    Future<void> getSearchProduct(String value,)async{
   
       if (value.isNotEmpty) {
  isFirebaseDataLoding = true;
  notifyListeners();
   String searchVelue= value.toLowerCase().replaceAll(" ", "");
       var getSearchData= await FirebaseFirestore.instance.collection("products")
      
       .where("keywords",arrayContains: searchVelue).limit(8).get();
     productList=[];
       
   productList=  productsDocsGetModel(getSearchData.docs);
  
    isFirebaseDataLoding = false;
}else{
  clearData();
  
}
          notifyListeners();  
            
   }
   void localsetState(){
    productList;
    notifyListeners();
   }
}
