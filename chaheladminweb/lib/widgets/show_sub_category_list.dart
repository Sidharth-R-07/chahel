import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/models/sub_category_model.dart';
import 'package:ecommerceadminweb/provider/sub_category_provider.dart';
import 'package:ecommerceadminweb/widgets/custom_network_image.dart';
import 'package:ecommerceadminweb/widgets/custom_popup.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:ecommerceadminweb/widgets/sub_cate_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../provider/get_catergory_provider.dart';
import '../screens/product_upload_screen.dart';
import '../services/build_search_keywords.dart';
import '../services/upload_firestore_image_services.dart';

class ShowSubCategoryList extends StatefulWidget {
  final String categoryId;
  const ShowSubCategoryList({super.key, required this.categoryId});

  @override
  State<ShowSubCategoryList> createState() => _ShowSubCategoryListState();
}

class _ShowSubCategoryListState extends State<ShowSubCategoryList> {
  bool loadingSubCat = false;
  final editeTitleController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int limit = 5;
  bool _gettingMoreSubCat = false;
  bool showMoreBtn = false;
  bool _moreSubCateAvailable = true;
  final _scrollController = ScrollController();
  bool loadMore = false;
  bool awaitLoading = false;
  bool deleteLoading = false;
  bool editeLoading = false;
  final editeInputController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _formKeyEditeSubCat = GlobalKey<FormState>();

  Uint8List? selectedImage;

  List<SubCategoryModel> subCategoryList = [];
  late SubCategoryModel lastsubCat;

  Future<void> _getSubCategories() async {
    final subCategoryRef = firestore
        .collection('category')
        .doc(widget.categoryId)
        .collection('sub-category');
    try {
      setState(() {
        loadingSubCat = true;
      });

      final snapshot = await subCategoryRef
          .orderBy('createdAt', descending: true)
          .limit(limit + 4)
          .get();

      final fetchedList = snapshot.docs
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

      lastsubCat = fetchedList[fetchedList.length - 1];

      log('PRINT FtechedDta CATEGORY LIST :${fetchedList.toString()}');

      setState(() {
        subCategoryList = fetchedList;
        loadingSubCat = false;
      });

      log('PRINT SUB CATEGORY LIST :${subCategoryList.toString()}');
    } on PlatformException catch (err) {
      erroetoast(err.message.toString());
    } catch (err) {
      print('ERROR IN _GET SUB-CATEGORY FUNCTION:${err.toString()}');
    } finally {
      setState(() {
        loadingSubCat = false;
      });
    }
  }

  _getMoreSubCategory() async {
    log('GET MORE FUNCTION CALLED');
    final subCategoryRef = firestore
        .collection('category')
        .doc(widget.categoryId)
        .collection('sub-category');

    if (_moreSubCateAvailable == false) {
      return;
    }

    if (_gettingMoreSubCat == true) {
      return;
    }
    try {
      awaitLoading = true;
      _gettingMoreSubCat = true;
      final snapshot = await subCategoryRef
          .orderBy('createdAt', descending: true)
          .startAfter([lastsubCat.createdAt])
          .limit(limit)
          .get();

      final fetchedList = snapshot.docs
          .map<SubCategoryModel>((data) => SubCategoryModel(
              categoryId: data['categoryId'],
              createdAt: data['createdAt'],
              image: data['image'],
              subCategorId: data['subCategorId'],
              title: data['title']))
          .toList();

      if (fetchedList.length < limit) {
        _moreSubCateAvailable = false;
      }

      lastsubCat = fetchedList[fetchedList.length - 1];

      setState(() {
        subCategoryList.addAll(fetchedList);
      });
      awaitLoading = false;
      _gettingMoreSubCat = false;
    } on PlatformException catch (err) {
      erroetoast(err.message.toString());
    } catch (err) {
      log('ERROR IN _getMoreUser FUNCTION:${err.toString()}');
    } finally {
      setState(() {
        loadingSubCat = false;
      });
    }
  }

  @override
  void initState() {
    _getSubCategories();

    ///LISTENING SCROLL POSITION
    _scrollController.addListener(() async {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      // log('Current Controll $currentScroll');

      ///IF SCROLLING POSITION IN END THEN SHOW LOADING AND GETMORE USERS
      if (maxScroll == currentScroll && awaitLoading == false) {
        log('Current Controll=MAX CONTROLL');
        setState(() {
          showMoreBtn = true;
          loadMore = true;
        });
        _getMoreSubCategory();

        if (_moreSubCateAvailable == false) {
          setState(() {
            showMoreBtn = false;
          });
        }

        setState(() {
          loadMore = false;
        });
      } else {
        setState(() {
          showMoreBtn = false;
          loadMore = false;
          _gettingMoreSubCat = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subCatProvider = Provider.of<SubCategoryProvider>(context);
    final subCatList = subCatProvider.subcategoryList;

    setState(() {
      subCategoryList.insertAll(0, [...subCatList]);
      subCatList.clear();
    });
    if (loadingSubCat) {
      return Center(
        child: LoadingAnimationWidget.waveDots(color: Colors.grey, size: 35),
      );
    } else if (subCategoryList.isEmpty) {
      return const Center(
        child: Text('NO SUB-CATEGORIES AVAILABLE NOW!'),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: subCategoryList.length,
              itemBuilder: (context, index) {
                final subCateGory = subCategoryList[index];
                return SubCatTile(
                  subCategory: subCateGory,
                  onTap: () {
                    ///goto ADD PRODUCTS SCREEN-------------------------------------------------
                    ///
                    log("SUB CATEGORY :$subCateGory");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductUploadScreen(
                            subCategoryModel: subCateGory,
                          );
                        },
                      ),
                    );
                  },
                  deleteFn: () async {
                    _showDeleteDilog(subCatProvider, subCateGory);

                    setState(() {});
                  },
                  editeFn: () async {
                    await _showEditeSubCategoryPopup(
                        context: context,
                        subCatProvider: subCatProvider,
                        subCategory: subCateGory);

                    setState(() {});
                  },
                );
              },
            ),
          ),
          if (showMoreBtn)
            const CupertinoActivityIndicator(
              color: appcolor1,
              radius: 15,
            )
        ],
      ),
    );
  }

  void _showDeleteDilog(
          SubCategoryProvider subCategoryProvider, SubCategoryModel subcat) =>
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                title: deleteLoading
                    ? const Text('Deleting....')
                    : const Text('Delete'),
                content: deleteLoading
                    ? const CupertinoActivityIndicator(
                        radius: 22,
                      )
                    : const Text('Do you want to delete this sub-category?'),
                actions: <Widget>[
                  deleteLoading
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                  deleteLoading
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: () async {
                            setState(() {
                              deleteLoading = true;
                            });
                            await _deleteSubCat(subCategoryProvider, subcat);

                            setState(() {
                              deleteLoading = false;
                            });
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                ],
              ),
            );
          });

  Future<Uint8List?> _selectSubCategoryImage() async {
    try {
      setState(() {
        editeLoading = true;
      });
      final imagepicker = ImagePicker();
      final file = await imagepicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        final _selectedImage = await file.readAsBytes();
        setState(() {
          selectedImage = _selectedImage;
          editeLoading = false;
        });
        return selectedImage;
      }
    } on PlatformException catch (err) {
      log('ERROR OCCURED !:${err.message}');
      setState(() {
        editeLoading = false;
      });

      if (err != null) {
        setState(() {
          editeLoading = false;
        });
        erroetoast(err.message!);
      } else {
        setState(() {
          editeLoading = false;
        });
        erroetoast('Something wrong!try again');
      }
    }

    print('SELECTED CATEGORY IMAGE:$selectedImage');
  }

  _showEditeSubCategoryPopup(
      {required BuildContext context,
      required SubCategoryModel subCategory,
      required SubCategoryProvider subCatProvider}) {
    editeInputController.text = subCategory.title!;

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: editeLoading ? const SizedBox.shrink() : const Text('Edite'),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          children: editeLoading == true
              ? [
                  const CupertinoActivityIndicator(
                    radius: 20,
                  ),
                  const Center(
                    child: Text(
                      'Updating Data...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ]
              : <Widget>[
                  const SizedBox(height: 8),
                  Form(
                    key: _formKeyEditeSubCat,
                    child: TextFormField(
                      controller: editeInputController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        } else if (value.length < 3) {
                          return 'title must be 3 chharacter';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'title',
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: selectedImage != null
                          ? Image.memory(
                              selectedImage!,
                              fit: BoxFit.contain,
                            )
                          : Image.network(
                              subCategory.image!,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final _getImage = await _selectSubCategoryImage();

                      setState(() {
                        selectedImage = _getImage;
                      });
                    },
                    icon: const Icon(Icons.refresh_outlined),
                    label: const Text('Change picture'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Back')),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String? imageUrl;

                          List<String>? _keywords;
                          final isValid =
                              _formKeyEditeSubCat.currentState!.validate();

                          if (!isValid) {
                            return;
                          }
                          setState(() {
                            editeLoading = true;
                          });

                          if (selectedImage != null) {
                            imageUrl = await uploadFirestoreImageServices(
                                selectedImage!);
                          } else {
                            imageUrl = subCategory.image;
                          }

                          if (editeTitleController.text.trim() ==
                              subCategory.title) {
                            _keywords = subCategory.keywords;

                            log('KEYWORD NOT CHANGED :${_keywords.toString()}');
                          } else {
                            _keywords = keywordsBuilder(
                                editeInputController.text.trim());
                            log('KEYWORD  :${_keywords.toString()}');
                          }

                          final editedSubCat = SubCategoryModel(
                              title: editeInputController.text.trim(),
                              categoryId: subCategory.categoryId,
                              createdAt: Timestamp.now(),
                              image: imageUrl,
                              keywords: _keywords,
                              subCategorId: subCategory.subCategorId);
                          await subCatProvider
                              .editeSUbCategory(subcategory: editedSubCat)
                              .then((_) {
                            final itemIndex =
                                subCategoryList.indexOf(subCategory);
                            log('Sub Category ITEM INDEX : $itemIndex');
                            setState(() {
                              subCategoryList[itemIndex] = editedSubCat;
                            });

                            log('Sub Category Updated ');

                            setState(() {
                              editeLoading = false;
                            });
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  )
                ],
        ),
      ),
    );
  }

  Future<void> _deleteSubCat(
      SubCategoryProvider subCategoryProvider, SubCategoryModel subCat) async {
    await subCategoryProvider
        .deleteSubCategory(
            categoryId: subCat.categoryId!, subCategoryId: subCat.subCategorId!)
        .then((_) {
      Navigator.of(context).pop();
      subCategoryList.removeWhere(
          (element) => element.subCategorId == subCat.subCategorId);
    });

    setState(() {});
  }
}
