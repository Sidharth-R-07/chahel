import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/user_details_model.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<UserDetailsModel> usersList = [];
  bool isFirebaseDataLoding = true;
  bool isNextListDataLoding = false;
  bool? circularProgressLOading = true;
  bool? isSearchawait = false;

  Future<void> getFirebaseData(
      QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc) async {
    isSearchawait = true;

    if (usersList.isEmpty) {
      isFirebaseDataLoding = true;
    }
    isNextListDataLoding = true;
    notifyListeners();

    QuerySnapshot<Map<String, dynamic>> refreshedClass = lastdoc == null
        ? await FirebaseFirestore.instance
            .collection("users")
            .orderBy("timestamp", descending: true)
            .limit(10)
            .get()
        : await FirebaseFirestore.instance
            .collection("users")
            .orderBy("timestamp", descending: true)
            .startAfterDocument(lastdoc)
            .limit(8)
            .get();

    if (lastdoc == null) {
      clearData();
    }
    isFirebaseDataLoding = false;
    if (refreshedClass.docs.length >= (lastdoc == null ? 10 : 8)) {
    } else {
      circularProgressLOading = false;

      // notifyListeners();
    }
    log("${refreshedClass.docs.length}......................");
    for (var element in refreshedClass.docs) {
      usersList.add(UserDetailsModel(
        name: element.data()["name"],
        phoneNumber: element.data()["phoneNumber"],
        city: element.data()["city"],
        houseNoBuilding: element.data()["houseNoBuilding"],
        pincode: element.data()["pincode"],
        roadname: element.data()["roadname"],
        state: element.data()["state"],
        userImage: element.data()["userImage"],
        userID: element.id,
        lastdoc: element,
      ));
    }
    log("2");

    isNextListDataLoding = false;

    notifyListeners();
  }

  Future<void> getSearchcatergory(String velue) async {
    if (velue.isNotEmpty) {
      isSearchawait = false;
      isFirebaseDataLoding = true;
      notifyListeners();
      velue.toLowerCase().replaceAll(" ", "");
      var getSearchData = await FirebaseFirestore.instance
          .collection("users")
          .where("phoneNumber", isEqualTo: velue)
          .limit(5)
          .get();
      usersList = [];

      if (isSearchawait == false) {
        for (var element in getSearchData.docs) {
          usersList.add(UserDetailsModel(
            name: element.data()["name"],
            phoneNumber: element.data()["phoneNumber"],
            city: element.data()["city"],
            houseNoBuilding: element.data()["houseNoBuilding"],
            pincode: element.data()["pincode"],
            roadname: element.data()["roadname"],
            state: element.data()["state"],
            userImage: element.data()["userImage"],
            userID: element.id,
            lastdoc: element,
          ));
        }
      }

      isFirebaseDataLoding = false;
    } else {
      getFirebaseData(null);
    }
    notifyListeners();
  }

  void clearData() {
    usersList = [];
    isFirebaseDataLoding = true;
    isNextListDataLoding = false;
    circularProgressLOading =
        true; //data loading bottom circularProgress condition variable
    isSearchawait = false;
    notifyListeners();
  }
}
