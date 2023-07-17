import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/product_parameters_model.dart';

class ProductDetailsModel {
  String name;
  List<ProductParametersModel>? productParameters;
  List image;
  String? byetimage;
  String description;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  //
  bool? productType;
  String? categoryID;
  String productID;
  String? bannerID;
  bool? reviewStatus;
  String? offerID;

  ProductDetailsModel({
    this.byetimage,
    this.categoryID,
    required this.description,
    required this.image,
    required this.name,
    this.productType,
    required this.productID,
    this.productParameters,
    this.bannerID,
    this.offerID,
    this.reviewStatus,
    this.lastdoc,
  });
}
