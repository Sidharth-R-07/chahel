

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';

List<CategoryModel> categoryDocsGetModel(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs){
  List<CategoryModel> catergoryList=[];
 for (var element in docs) {
        
      catergoryList.add(
       
        CategoryModel(
          image: element.data()["image"],
          name: element.data()["name"],
          categoryID: element.id,
           lastdoc: element,
        ),
      );
    }
    return catergoryList;
}