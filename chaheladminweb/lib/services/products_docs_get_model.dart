import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_details_model.dart';
import '../models/product_parameters_model.dart';

List<ProductDetailsModel> productsDocsGetModel(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
  List<ProductDetailsModel> productList = [];
  for (var element in docs) {
    List<ProductParametersModel> productParametersList = [];

    (element.data()["parameters"] ?? {}).forEach((key, value) {
      productParametersList.add(ProductParametersModel(
        parametersID: key,
        uint: value["uint"],
        mrp: value["mrp"],
        rs: value["rs"],
        stock: value["stock"],
        index: value["index"] ?? 0,
      ));
    });

    productParametersList
        .sort((a, b) => (a.index ?? 0).compareTo(b.index ?? 0));

    productList.add(ProductDetailsModel(
        name: element.data()["name"],
        productParameters: productParametersList,
        image: element.data()["image"],
        byetimage: element.data()["byetimage"],
        productType: element.data()["productType"],
        description: element.data()["description"],
        categoryID: element.data()["categoryID"],
        productID: element.id,
        offerID: element.data()["offerID"],
        bannerID: element.data()["bannerID"],
        lastdoc: element,
        reviewStatus: element.data()["reviewStatus"]));
  }
  return productList;
}
