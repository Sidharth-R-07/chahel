

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_details_model.dart';
import '../services/products_docs_get_model.dart';

class OfferProductProvider extends ChangeNotifier{



   
     List<ProductDetailsModel> productList = [];
  bool isFirebaseDataLoding = false;
  bool isNextListDataLoding = false;
  bool? circularProgressLOading = true;
  bool? isSearchawait=false;



  Future<void> getFirebaseData(String offerElementID,
      QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc) async {
        isSearchawait=true;
    if (lastdoc == null) {
     clearData();
  
    }

    if (productList.isEmpty) {
      isFirebaseDataLoding = true;
    }
    isNextListDataLoding = true;

    notifyListeners();
    QuerySnapshot<Map<String, dynamic>> refreshedClass = lastdoc == null
        ? await FirebaseFirestore.instance
            .collection("products")
            .where("offerID",isEqualTo: offerElementID)
            
            .limit(8)
            .get()
        : await FirebaseFirestore.instance
            .collection("products")
            .where("offerID",isEqualTo: offerElementID)
           
            .startAfterDocument(lastdoc)
            .limit(4)
            .get();
   

    isFirebaseDataLoding = false;
    if (refreshedClass.docs.length >= 4) {
    } else {
      circularProgressLOading = false;

      notifyListeners();
    }
    productList.addAll(productsDocsGetModel(refreshedClass.docs));

    isNextListDataLoding=false;

    notifyListeners();
  }

  void removeAt(int index){
    productList.removeAt(index);
    notifyListeners();
  }
 
    void clearData() {
    productList.clear();
    isFirebaseDataLoding = false;
    circularProgressLOading =
        true; //data loading bottom circularProgress condition variable
    isNextListDataLoding = false;
    notifyListeners();
  }
 

}