
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/Enums/order_enum.dart';
import 'package:ecommerceadminweb/models/user_details_model.dart';

class OrderModel {
   String userID;
  String orderID;
  String orderDocmentID;
  Timestamp ordertime;
  bool isonlinepayment;
  double amount;
  Orderenum ordertracking;
  int? shippingcharge;
  List<OrderProductsModel> productList;
  UserDetailsModel userDetails;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  OrderModel(
      {
         required this. userID,
        required this.orderID,
        required this.orderDocmentID,
      required this.ordertime,
      required this.isonlinepayment,
      required this.amount,
      required this.ordertracking,
      this.shippingcharge,
      required this.productList,
      required this.userDetails,
      this.lastdoc, 
      });
}




class OrderProductsModel {
  String name;
  String image;
  double? mrp;
  double rs;
  String unit;
  String description;
  int qty;
  bool? productType;
  String productID;
  OrderProductsModel(
      {required this.name,
      required this.image,
       this.mrp,
      required this.rs,
      required this.unit,
      required this.description,
      required this.qty,
      this.productType,
      required this.productID});
}
