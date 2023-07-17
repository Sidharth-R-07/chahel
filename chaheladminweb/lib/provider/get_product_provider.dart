import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/models/product_details_model.dart';
import 'package:ecommerceadminweb/services/products_docs_get_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/sub_category_model.dart';

class GetProductProvider extends ChangeNotifier {
  List<ProductDetailsModel> productList = [];
  bool isFirebaseDataLoding = false;
  bool isNextListDataLoding = false;
  bool? ircularProgressLOading = true;
  bool? isSearchawait = false;

  Future<void> getFirebaseData(SubCategoryModel categorydetails,
      QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc) async {
    isSearchawait = true;
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
            .where("subCategoryId", isEqualTo: categorydetails.subCategorId)
            .orderBy("timestamp", descending: true)
            .limit(8)
            .get()
        : await FirebaseFirestore.instance
            .collection("products")
            .where("subCategoryId", isEqualTo: categorydetails.subCategorId)
            .orderBy("timestamp", descending: true)
            .startAfterDocument(lastdoc)
            .limit(4)
            .get();

    isFirebaseDataLoding = false;
    if (refreshedClass.docs.length >= 4) {
    } else {
      ircularProgressLOading = false;

      notifyListeners();
    }
    productList.addAll(productsDocsGetModel(refreshedClass.docs));

    isNextListDataLoding = false;

    notifyListeners();
  }

  void removeAt(int index) {
    productList.removeAt(index);
    notifyListeners();
  }

  void localedit(ProductDetailsModel productDetails) {
    for (var element in productList) {
      if (element.productID == productDetails.productID) {
        element.name = productDetails.name;
        element.byetimage = productDetails.byetimage;
        element.image = productDetails.image;
        element.lastdoc = productDetails.lastdoc;
        element.productType = productDetails.productType;
        element.productParameters = productDetails.productParameters;
        element.description = productDetails.description;
        element.reviewStatus = productDetails.reviewStatus;
        notifyListeners();
        return;
      }
    }
  }

  Future<void> getSearchProduct(
      String value, SubCategoryModel categorydetails) async {
    if (value.isNotEmpty) {
      isSearchawait = false;
      isFirebaseDataLoding = true;
      notifyListeners();

      String newvalue = value.toLowerCase().replaceAll(" ", "");

      var getSearchData = await FirebaseFirestore.instance
          .collection("products")
          .where("subCategoryId", isEqualTo: categorydetails.subCategorId)
          .where("keywords", arrayContains: newvalue)
          .limit(8)
          .get();
      clearData();

      if (isSearchawait == false) {
        productList.addAll(productsDocsGetModel(getSearchData.docs));
      }

      isFirebaseDataLoding = false;
    } else {
      clearData();
      getFirebaseData(categorydetails, null);
    }
    notifyListeners();
  }

  void clearData() {
    productList.clear();
    isFirebaseDataLoding = false;
    ircularProgressLOading =
        true; //data loading bottom circularProgress condition variable
    isNextListDataLoding = false;
    notifyListeners();
  }
}
