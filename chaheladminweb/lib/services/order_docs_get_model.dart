import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/order_model.dart';

import '../Enums/order_enum.dart';
import '../models/user_details_model.dart';

List<OrderModel> orderDocsGetModel(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  List<OrderModel> orderList = [];

  for (var element in docs) {
    List<OrderProductsModel> productList = [];

    final snap = element.data()['productsData'];
    snap.forEach((key, value) {
      log("IN LOOP KEY:$key");
      productList.add(
        OrderProductsModel(
          name: value["name"],
          image: value["image"],
          qty: value["Qty"],
          unit: value["uint"],
          rs: (value["rs"] ?? 0).toDouble(),
          mrp: (value["mrp"] ?? 0).toDouble(),
          description: value["description"],
          productType: value["productType"],
          productID: value["productID"],
        ),
      );
      final _prodId = value['productID'];
      final _rating = value['rating'];

      log(" PRODUCT ID:$_prodId    :RATING :$_rating  ");
    });

    // order status
    Orderenum ordertracking; //=Orderenum.pending;
    int? status = element.data()["ordertracking"];
    if (status == 0) {
      ordertracking = Orderenum.pending;
    } else if (status == 1) {
      ordertracking = Orderenum.accepted;
    } else if (status == 2) {
      ordertracking = Orderenum.packed;
    } else if (status == 3) {
      ordertracking = Orderenum.shipped;
    } else if (status == 4) {
      ordertracking = Orderenum.delivered;
    } else if (status == 404) {
      ordertracking = Orderenum.other;
    } else {
      ordertracking = Orderenum.pending;
    }

    orderList.add(
      OrderModel(
        userID: element.data()["userID"],
        orderID: element.data()["orderID"],
        ordertime: element.data()["ordertime"],
        isonlinepayment: element.data()["isonlinepayment"],
        amount: element.data()["amount"],
        ordertracking: ordertracking,
        shippingcharge: element.data()["shippingcharge"],
        orderDocmentID: element.id,
        lastdoc: element,
        productList: productList,
        //userData
        userDetails: UserDetailsModel(
          name: element.data()["userData"]["name"],
          phoneNumber: element.data()["userData"]["phoneNumber"],
          city: element.data()["userData"]["city"],
          houseNoBuilding: element.data()["userData"]["houseNoBuilding"],
          ishome: element.data()["userData"]["ishome"],
          pincode: element.data()["userData"]["pincode"],
          roadname: element.data()["userData"]["roadname"],
          state: element.data()["userData"]["state"],
        ),
      ),
    );
  }

  return orderList;
}
