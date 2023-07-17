import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  Timestamp? createdAt;
  String? title;
  String? categoryId;
  String? subCategorId;
  String? image;
  List<String>? keywords;
  SubCategoryModel(
      {this.createdAt,
      this.subCategorId,
      this.title,
      this.image,
      this.keywords,
      this.categoryId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'title': title,
      'keywords': keywords,
      'image': image,
      'categoryId': categoryId,
      'subCategorId': subCategorId,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
        categoryId: map['categoryId'],
        keywords: map['keywords'],
        title: map['title'],
        subCategorId: map['subCategorId'],
        image: map['image'],
        createdAt: map['createdAt']);
  }
}
