import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import '../models/product_details_model.dart';
import '../services/products_docs_get_model.dart';

class GetAllProductProvider extends ChangeNotifier {
  List<ProductDetailsModel> productList = [];
  bool isFirebaseDataLoding = false;
  bool isNextListDataLoding = false;
  bool? circularProgressLOading = true;
  bool? isSearchawait = false;

  Future<void> getFirebaseData(
      QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc,
      bool isAllproducts) async {
    if (productList.isEmpty) {
      isFirebaseDataLoding = true;
      notifyListeners();
    }
    isSearchawait = true;
    isNextListDataLoding = true;
    notifyListeners();

    QuerySnapshot<Map<String, dynamic>>? refreshedClass;

    if (isAllproducts == true) {
      refreshedClass = lastdoc == null
          ? await FirebaseFirestore.instance
              .collection("products")
              .orderBy("timestamp", descending: true)
              .limit(8)
              .get()
          : await FirebaseFirestore.instance
              .collection("products")
              .orderBy("timestamp", descending: true)
              .startAfterDocument(lastdoc)
              .limit(4)
              .get();
    } else {
      refreshedClass = lastdoc == null
          ? await FirebaseFirestore.instance
              .collection("products")
              .where("stockout", isEqualTo: true)
              .orderBy("timestamp", descending: true)
              .limit(8)
              .get()
          : await FirebaseFirestore.instance
              .collection("products")
              .where("stockout", isEqualTo: true)
              .orderBy("timestamp", descending: true)
              .startAfterDocument(lastdoc)
              .limit(4)
              .get();
    }

    if (lastdoc == null) {
      clearData();
    }
    isFirebaseDataLoding = false;
    if ((refreshedClass.docs.length) >= 4) {
    } else {
      circularProgressLOading = false;

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

  Future<void> getSearchProduct(String value) async {
    if (value.isNotEmpty) {
      isSearchawait = false;
      isFirebaseDataLoding = true;
      notifyListeners();

      String newvalue = value.toLowerCase().replaceAll(" ", "");

      var getSearchData = await FirebaseFirestore.instance
          .collection("products")
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
      getFirebaseData(null, true);
    }
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
