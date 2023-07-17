import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/Enums/order_enum.dart';
import 'package:ecommerceadminweb/models/order_model.dart';
import 'package:flutter/material.dart';

import '../services/order_docs_get_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];
  bool isFirebaseDataLoding = false;
  bool isNextListDataLoding = false;
  bool? circularProgressLOading = true;
  bool? isSearchawait = false;

  Future<void> getFirebaseData(
      QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc,
      Orderenum orserStatus,
      String? searchValue) async {
    isSearchawait = true;
    if (lastdoc == null) {
      isFirebaseDataLoding = true;

      notifyListeners();
    }

    // if (orderList.isEmpty) {

    // }
    isNextListDataLoding = true;

    notifyListeners();

    QuerySnapshot<Map<String, dynamic>>? refreshedClass;
    //search order
    if (searchValue != null) {
      if (num.tryParse(searchValue) != null) {
        //phone number
        refreshedClass = (lastdoc == null)
            ? await FirebaseFirestore.instance
                .collection("orders")
                .orderBy("ordertime", descending: true)
                .where("userData.phoneNumber", isEqualTo: searchValue)
                .limit(10)
                .get()
            : await FirebaseFirestore.instance
                .collection("orders")
                .where("userData.phoneNumber", isEqualTo: searchValue)
                .orderBy("ordertime", descending: true)
                .startAfterDocument(lastdoc)
                .limit(5)
                .get();
      } else {
        //order ID
        refreshedClass = (lastdoc == null)
            ? await FirebaseFirestore.instance
                .collection("orders")
                .where("orderID", isEqualTo: searchValue)
                .limit(10)
                .get()
            : await FirebaseFirestore.instance
                .collection("orders")
                .where("orderID", isEqualTo: searchValue)
                .startAfterDocument(lastdoc)
                .limit(5)
                .get();
      }

      ///search order end
    } else if (orserStatus == Orderenum.all) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .orderBy("ordertime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .orderBy("ordertime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    } else if (orserStatus == Orderenum.pending) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 0)
              .orderBy("ordertime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 0)
              .orderBy("ordertime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    } else if (orserStatus == Orderenum.accepted) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 1)
              .orderBy("orderchangetime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 1)
              .orderBy("orderchangetime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    } else if (orserStatus == Orderenum.packed) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 2)
              .orderBy("orderchangetime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 2)
              .orderBy("orderchangetime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    } else if (orserStatus == Orderenum.shipped) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 3)
              .orderBy("orderchangetime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 3)
              .orderBy("orderchangetime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    } else if (orserStatus == Orderenum.delivered) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 4)
              .orderBy("orderchangetime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 4)
              .orderBy("orderchangetime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    } else if (orserStatus == Orderenum.other) {
      refreshedClass = (lastdoc == null)
          ? await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 404)
              .orderBy("orderchangetime", descending: true)
              .limit(10)
              .get()
          : await FirebaseFirestore.instance
              .collection("orders")
              .where("ordertracking", isEqualTo: 404)
              .orderBy("orderchangetime", descending: true)
              .startAfterDocument(lastdoc)
              .limit(5)
              .get();
    }

    if (lastdoc == null) {
      clearData();
      notifyListeners();
    }

    isFirebaseDataLoding = false;
    if ((refreshedClass?.docs.length ?? 0) >= (lastdoc == null ? 10 : 5)) {
    } else {
      circularProgressLOading = false;

      notifyListeners();
    }

    orderList.addAll(orderDocsGetModel(refreshedClass?.docs ?? []));

    isNextListDataLoding = false;

    notifyListeners();
  }

  // void searchOrder(String value){
  //  if(num.tryParse(value)!=null){

  //  }else{

  //  }
  // }

  void clearData() {
    isFirebaseDataLoding = true;
    orderList = [];
    circularProgressLOading =
        true; //data loading bottom circularProgress condition variable
    isNextListDataLoding = false;
    notifyListeners();
  }
}
