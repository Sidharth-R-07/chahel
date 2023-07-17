import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String image;
  String name;
  String categoryID;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;
  CategoryModel({required this.image,required this.name,required this.categoryID,this.lastdoc});
}