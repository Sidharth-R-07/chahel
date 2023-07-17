import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/methods.dart';
import 'package:ecommerceadminweb/models/sub_category_model.dart';
import 'package:ecommerceadminweb/services/build_search_keywords.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';

class SubCategoryProvider with ChangeNotifier {
  List<SubCategoryModel> subcategoryList = [];
  List<SubCategoryModel> searchList = [];
  final firestore = FirebaseFirestore.instance;

  Future<void> addSubCategory({required SubCategoryModel subCategory}) async {
    String newSubId = firestore
        .collection("category")
        .doc(subCategory.categoryId)
        .collection('sub-category')
        .doc()
        .id;
    final ref = firestore
        .collection('category')
        .doc(subCategory.categoryId)
        .collection('sub-category')
        .doc(newSubId);
    final _keywords = keywordsBuilder(subCategory.title!);
    await ref.set({
      'createdAt': subCategory.createdAt,
      'title': subCategory.title,
      'keywords': _keywords,
      'image': subCategory.image,
      'categoryId': subCategory.categoryId,
      'subCategorId': newSubId,
    });
    subcategoryList.add(
      SubCategoryModel(
          categoryId: subCategory.categoryId,
          createdAt: subCategory.createdAt,
          image: subCategory.image,
          subCategorId: newSubId,
          title: subCategory.title),
    );
    notifyListeners();
  }

  Future<void> searchSubCategory(String categoryId, String searchText) async {
    final ref = firestore
        .collection('category')
        .doc(categoryId)
        .collection('sub-category');

    final fetchedData = await ref
        .where('keywords'.toLowerCase(),
            arrayContains: searchText.toLowerCase())
        .get();

    searchList = fetchedData.docs
        .map<SubCategoryModel>(
          (data) => SubCategoryModel(
            categoryId: data['categoryId'],
            createdAt: data['createdAt'],
            image: data['image'],
            subCategorId: data['subCategorId'],
            title: data['title'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> getSubCategory({required String categoryId}) async {
    final fetchedData = await firestore
        .collection('category')
        .doc(categoryId)
        .collection('sub-category')
        .get();
    final jsonData = fetchedData.docs as List<Map<String, dynamic>>;

    print('FETCHED DATA:$jsonData');
  }

  Future<void> editeSUbCategory({required SubCategoryModel subcategory}) async {
    try {
      await firestore
          .collection('category')
          .doc(subcategory.categoryId)
          .collection('sub-category')
          .doc(subcategory.subCategorId)
          .update(subcategory.toMap());

      notifyListeners();
    } on FirebaseException catch (err) {
      log('ERROR IN UPDATING');
      erroetoast(err.message.toString());
    } catch (err) {
      erroetoast(err.toString());
      log('error occured');
    }
  }

  Future<void> deleteSubCategory(
      {required String categoryId, required String subCategoryId}) async {
    try {
      await firestore
          .collection('category')
          .doc(categoryId)
          .collection('sub-category')
          .doc(subCategoryId)
          .delete();

      searchList
          .removeWhere((element) => element.subCategorId == subCategoryId);
      notifyListeners();
      showToast(text: 'Sub-category daleted');
    } on FirebaseException catch (err) {
      erroetoast(err.message.toString());
    } catch (err) {
      erroetoast('Something went wrong!');
    }
  }
}
