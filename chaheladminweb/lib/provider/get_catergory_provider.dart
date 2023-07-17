import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/services/category_docs_get_model.dart';
import 'package:flutter/cupertino.dart';

class GetCatergoryProvider extends ChangeNotifier {
  List<CategoryModel> catergoryList = [];
  bool isFirebaseDataLoding = true;
  bool isNextListDataLoding = false;
  bool? circularProgressLOading = true; 
  bool? isSearchawait=false; 

  Future<void> getFirebaseData(
      QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc) async {
        isSearchawait=true;
       
    if (lastdoc == null) {
      clearData();
    }

    if (catergoryList.isEmpty) {
      isFirebaseDataLoding = true;
    }
    isNextListDataLoding=true;
    //notifyListeners();

    QuerySnapshot<Map<String, dynamic>> refreshedClass = lastdoc == null
        ? await FirebaseFirestore
            .instance //FirebaseFirestore.instance.collection("category").orderBy("timestamp",descending: true).
            .collection("category")
            .orderBy("timestamp", descending: true)
            .limit(12)
            .get()
        : await FirebaseFirestore.instance
            .collection("category")
            .orderBy("timestamp", descending: true)
            .startAfterDocument(lastdoc)
            .limit(8)
            .get();

    isFirebaseDataLoding = false;
    if (refreshedClass.docs.length >= (lastdoc==null?12:8)) {
    } else {
      circularProgressLOading = false;

     // notifyListeners();
    }

    catergoryList.addAll(categoryDocsGetModel(refreshedClass.docs));

    isNextListDataLoding=false;

    notifyListeners();
  }








 




    void addlocalData(CategoryModel category){
    catergoryList.insert(0, 
     category
    );
    notifyListeners();
  }



  void localedit(CategoryModel category) {
    for (var element in catergoryList) {
      if (element.categoryID == category.categoryID) {
        element.image = category.image;
        element.name = category.name;
        element.lastdoc=category.lastdoc;
        element.categoryID=category.categoryID;

        notifyListeners();
        return;
      }
    }
  }



  void removeAt(int index){
    catergoryList.removeAt(index);
    notifyListeners();
  }




  Future<void> getSearchcatergory(String velue) async {
    if (velue.isNotEmpty) {
      isSearchawait=false;
      isFirebaseDataLoding = true;
      notifyListeners();
        String searchVelue= velue.toLowerCase().replaceAll(" ", "");
       
      var getSearchData = await FirebaseFirestore.instance
          .collection("category")
          .where("keywords", arrayContains: searchVelue)
          .limit(8)
          .get();
      catergoryList = [];

      if (isSearchawait==false) {
        catergoryList.addAll(categoryDocsGetModel(getSearchData.docs));
      }

      isFirebaseDataLoding = false;
    } else {
      getFirebaseData(null);
    }
    notifyListeners();
  }
  
  
  
  
  
   void clearData() {
    catergoryList = [];
    isFirebaseDataLoding = true;
     isNextListDataLoding=false;
    circularProgressLOading =
        true; //data loading bottom circularProgress condition variable
     isSearchawait=false; 
    notifyListeners();
  }
}
