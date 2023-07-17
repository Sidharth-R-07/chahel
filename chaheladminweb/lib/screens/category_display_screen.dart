import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/general/methods.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';
import 'package:ecommerceadminweb/screens/category_edit_screen.dart';
import 'package:ecommerceadminweb/screens/product_upload_screen.dart';
import 'package:ecommerceadminweb/provider/sub_category_provider.dart';
import 'package:ecommerceadminweb/widgets/custom_popup.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/sub_category_model.dart';
import '../provider/get_catergory_provider.dart';
import '../services/build_search_keywords.dart';
import '../services/upload_firestore_image_services.dart';
import '../widgets/category_frame.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/show_sub_category_list.dart';
import '../widgets/sub_cate_tile.dart';
import 'category_upload_screen.dart';

class CategoryDisplyScreen extends StatefulWidget {
  const CategoryDisplyScreen({super.key});

  @override
  State<CategoryDisplyScreen> createState() => _CategoryDisplyScreenState();
}

class _CategoryDisplyScreenState extends State<CategoryDisplyScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  TextEditingController subcategorySearchController = TextEditingController();
  TextEditingController addsubCategoryController = TextEditingController();
  bool isOrderSortshutter = true;

  Uint8List? selectedSubCatImage;
  bool selectImageLoading = false;
  bool submitLoading = false;
  String? selectedCategoryId;
  bool showSubCategory = false;
  bool _showDailog = false;
  bool deleteLoading = false;
  Uint8List? selectedImage;
  bool editeLoading = false;

  bool searchLoading = false;

  final editeSubCatInputController = TextEditingController();

  String subCatSearchText = '';
  final key = GlobalKey();

  final _formKey = GlobalKey<FormState>();
  final _formKeyEditeSubCat = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetCatergoryProvider>(context, listen: false).clearData();
      Provider.of<GetCatergoryProvider>(context, listen: false)
          .getFirebaseData(null);
    });

    super.initState();
  }

  @override
  void dispose() {
    editeSubCatInputController.dispose();
    subcategorySearchController.dispose();
    addsubCategoryController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subCatProvider = Provider.of<SubCategoryProvider>(context);
    final searchResults = subCatProvider.searchList;
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            title: const Text(
              "Category",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (Provider.of<GetCatergoryProvider>(context, listen: false)
                          .isFirebaseDataLoding ==
                      false) {
                    showDialogAddcategory(context);
                  } else {
                    normeltoast("please wait...");
                  }
                },
                icon: const Icon(Icons.add),
                tooltip: "Add category",
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 5),
                  height: isOrderSortshutter ? null : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                Provider.of<GetCatergoryProvider>(context,
                                        listen: false)
                                    .getSearchcatergory(value);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Search Categories...",
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: const Icon(
                                  IconlyLight.search,
                                  color: Colors.black,
                                  size: 17,
                                ),
                                isDense: true,
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      if (searchController.text.isNotEmpty) {
                                        searchController.clear();
                                        setState(() {});
                                        await Provider.of<GetCatergoryProvider>(
                                                context,
                                                listen: false)
                                            .getFirebaseData(null);
                                      }
                                    },
                                    icon: const Icon(Icons.close)),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                                contentPadding: const EdgeInsets.all(10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Container(
                        width: 1100,
                        margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: isOrderSortshutter ? 20 : 0),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800),
                              ),
                              const Spacer(),
                              Text(
                                "Action",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Provider.of<GetCatergoryProvider>(context)
                                    .isFirebaseDataLoding ==
                                false
                            ? Provider.of<GetCatergoryProvider>(context)
                                    .catergoryList
                                    .isNotEmpty
                                ? SizedBox(
                                    width: 1100,
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            childCount: Provider.of<
                                                        GetCatergoryProvider>(
                                                    context)
                                                .catergoryList
                                                .length,
                                            (context, index) {
                                              final _categoryId = Provider.of<
                                                          GetCatergoryProvider>(
                                                      context)
                                                  .catergoryList[index]
                                                  .categoryID;
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedCategoryId =
                                                        _categoryId;
                                                    showSubCategory = true;
                                                  });
                                                },
                                                child: CategoryFrame(
                                                  categoryDetails: Provider.of<
                                                              GetCatergoryProvider>(
                                                          context)
                                                      .catergoryList[index],
                                                  delete: () {
                                                    customPoPup(
                                                        context,
                                                        "Delete",
                                                        "Delete this category",
                                                        () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "category")
                                                          .doc(
                                                            Provider.of<GetCatergoryProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .catergoryList[
                                                                    index]
                                                                .categoryID,
                                                          )
                                                          .delete();
                                                      Provider.of<GetCatergoryProvider>(
                                                              context,
                                                              listen: false)
                                                          .removeAt(index);

                                                      ///
                                                      /// last 12 ennam ayaalum and circularProgressLOading==true annegil veendum data get cheyyan
                                                      List<CategoryModel>
                                                          catergoryList =
                                                          Provider.of<GetCatergoryProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .catergoryList;
                                                      if (catergoryList
                                                                  .length <=
                                                              12 &&
                                                          Provider.of<GetCatergoryProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .circularProgressLOading ==
                                                              true) {
                                                        Provider.of<GetCatergoryProvider>(
                                                                context,
                                                                listen: false)
                                                            .getFirebaseData(
                                                                catergoryList
                                                                    .last
                                                                    .lastdoc);
                                                      }
                                                      //
                                                      if (catergoryList
                                                          .isEmpty) {
                                                        Provider.of<GetCatergoryProvider>(
                                                                context,
                                                                listen: false)
                                                            .getFirebaseData(
                                                                null);
                                                      }
                                                      Navigator.pop(context);
                                                    }, "OK");
                                                  },
                                                  edit: () {
                                                    showDialogEditcategory(
                                                        context,
                                                        Provider.of<GetCatergoryProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .catergoryList[
                                                            index]);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SliverToBoxAdapter(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Provider.of<GetCatergoryProvider>(
                                                                context)
                                                            .isFirebaseDataLoding ==
                                                        false &&
                                                    searchController
                                                        .text.isEmpty
                                                ? Provider.of<GetCatergoryProvider>(
                                                                context)
                                                            .circularProgressLOading ==
                                                        true
                                                    ? Tooltip(
                                                        message:
                                                            "Get the next list",
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          height: 45,
                                                          width: 45,
                                                          child: MaterialButton(
                                                            elevation: 3,
                                                            color: Colors.white,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            200))),
                                                            onPressed: () {
                                                              if (Provider.of<GetCatergoryProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isNextListDataLoding ==
                                                                  false) {
                                                                Provider.of<GetCatergoryProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .getFirebaseData(
                                                                  Provider.of<GetCatergoryProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .catergoryList
                                                                      .last
                                                                      .lastdoc,
                                                                );
                                                              }
                                                            },
                                                            child: Provider.of<GetCatergoryProvider>(
                                                                            context)
                                                                        .isNextListDataLoding ==
                                                                    false
                                                                ? const Icon(
                                                                    CupertinoIcons
                                                                        .add,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 22,
                                                                  )
                                                                : const Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            0.0,
                                                                        vertical:
                                                                            8),
                                                                    child:
                                                                        CupertinoActivityIndicator(),
                                                                  ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 45,
                                                        width: 1100,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                      )
                                                : Container(),
                                          ],
                                        )),
                                        const SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 300,
                                        width: 1100,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Category is empty...",
                                              style: TextStyle(
                                                fontFamily: "pop",
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 300,
                                    width: 1100,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        LoadingAnimationWidget.waveDots(
                                          color: Colors.grey,
                                          size: 70,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),

                ///-----------------------------------SHOWING SUB-CATEGORY-----------------------------

                (showSubCategory == true && selectedCategoryId != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              width: 360,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //------------------------------SUB-CATEGORY SEARCH FIELD------------------------
                                      SizedBox(
                                        width: 240,
                                        child: TextField(
                                          controller:
                                              subcategorySearchController,
                                          onChanged: (value) async {
                                            setState(() {
                                              subCatSearchText = value;
                                              searchLoading = true;
                                            });

                                            await subCatProvider
                                                .searchSubCategory(
                                                    selectedCategoryId!,
                                                    subCatSearchText);
                                            setState(() {
                                              searchLoading = false;
                                            });

                                            log('SEARCH FUNCTION CALLED!');
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintText:
                                                "Search  Sub-Categories...",
                                            fillColor: Colors.white,
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                            ),
                                            isDense: true,
                                            suffixIcon: IconButton(
                                                onPressed: () async {
                                                  if (subcategorySearchController
                                                      .text.isNotEmpty) {
                                                    subcategorySearchController
                                                        .clear();
                                                    setState(() {
                                                      subCatSearchText = '';
                                                    });
                                                  }
                                                },
                                                icon: const Icon(Icons.close)),
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _showDailog = true;
                                          });
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showSubCategory = false;

                                            setState(() {
                                              subCatSearchText = '';
                                              subcategorySearchController
                                                  .clear();
                                            });

                                            log('SHOW SUB CATEGORY:[$showSubCategory]');
                                          });
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  (subCatSearchText.isEmpty ||
                                          subCatSearchText == null)
                                      ? Expanded(
                                          child: ShowSubCategoryList(
                                          categoryId: selectedCategoryId!,
                                        ))

                                      ///SHOWING SEARCH LIST--------------------------------
                                      : searchResults.isEmpty
                                          ? searchLoading
                                              ? const Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                                    radius: 18,
                                                  ),
                                                )
                                              : const Center(
                                                  child: Text(
                                                      'NO SEARCH RESULT FOUND!'),
                                                )
                                          : Expanded(
                                              child: ListView.builder(
                                              itemCount:
                                                  searchResults.length > 8
                                                      ? 8
                                                      : searchResults.length,
                                              itemBuilder: (context, index) {
                                                final _subCat =
                                                    searchResults[index];

                                                return Center(
                                                  child: SubCatTile(
                                                    subCategory: _subCat,
                                                    onTap: () {
                                                      ///goto ADD PRODUCTS SCREEN-------------------------------------------------
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return ProductUploadScreen(
                                                              subCategoryModel: Provider.of<
                                                                          SubCategoryProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .subcategoryList[index],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    deleteFn: () {
                                                      _showDeleteDilog(
                                                          subCatProvider,
                                                          _subCat,
                                                          searchResults);

                                                      setState(() {});
                                                    },
                                                    editeFn: () async {
                                                      await _showEditeSubCategoryPopup(
                                                        context: context,
                                                        subCatProvider:
                                                            subCatProvider,
                                                        subCategory: _subCat,
                                                      );

                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              },
                                            )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),

                _showDailog
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _showAddSubCategoryPopup(),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()

                ///-----------------------------SHOW SUB-CATEGORY CLOSED--------------------------------
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///----------------------------------EDITE SUB -CATEGORY DILOG------------------------------------------------------------------------------------
  _showEditeSubCategoryPopup(
      {required BuildContext context,
      required SubCategoryModel subCategory,
      required SubCategoryProvider subCatProvider}) {
    editeSubCatInputController.text = subCategory.title!;

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: editeLoading ? const SizedBox.shrink() : const Text('Edit'),
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
                      controller: editeSubCatInputController,
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

                            if (editeSubCatInputController.text.trim() ==
                                subCategory.title) {
                              _keywords = subCategory.keywords;
                            } else {
                              _keywords = keywordsBuilder(
                                  editeSubCatInputController.text.trim());
                            }

                            final editedSubCat = SubCategoryModel(
                                title: editeSubCatInputController.text.trim(),
                                categoryId: subCategory.categoryId,
                                createdAt: Timestamp.now(),
                                image: imageUrl,
                                keywords: _keywords,
                                subCategorId: subCategory.subCategorId);
                            await subCatProvider
                                .editeSUbCategory(subcategory: editedSubCat)
                                .then((_) {
                              final itemIndex = subCatProvider.searchList
                                  .indexOf(subCategory);
                              log('Sub Category ITEM INDEX : $itemIndex');
                              setState(() {
                                subCatProvider.searchList[itemIndex] =
                                    editedSubCat;
                              });

                              log('Sub Category Updated ');

                              setState(() {
                                editeLoading = false;
                              });
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Text('Save'))
                    ],
                  )
                ],
        ),
      ),
    );
  }

  void _showDeleteDilog(SubCategoryProvider subCategoryProvider,
          SubCategoryModel subcat, List<SubCategoryModel> searchList) =>
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
                actions: deleteLoading
                    ? []
                    : <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              deleteLoading = true;
                            });
                            await subCategoryProvider
                                .deleteSubCategory(
                                    categoryId: subcat.categoryId!,
                                    subCategoryId: subcat.subCategorId!)
                                .then((_) {
                              Navigator.of(context).pop();

                              setState(() {
                                deleteLoading = false;
                              });
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

  ///--------------------------------ADD SUB-CATEGORY DAILOGUE---------------------------------

  Widget _showAddSubCategoryPopup() {
    return Container(
      width: submitLoading ? 350 : 480,
      height: submitLoading ? 280 : 480,
      padding: selectedSubCatImage != null
          ? const EdgeInsets.all(2)
          : const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: submitLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Adding Sub-catgory',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CupertinoActivityIndicator(
                      radius: 22,
                    )
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Center(
                    child: Text(
                      'Add Sub-category',
                      style: TextStyle(
                          color: appcolor1,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: 280,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: addsubCategoryController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter a title';
                          } else if (val.length < 3) {
                            return 'title must be 3 character';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "title",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          isDense: true,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _selectSubCategoryImage,
                    child: Container(
                      height: 250,
                      width: 250,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: selectedSubCatImage == null
                          ? const Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Select Image',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.grey),
                                ),
                                Icon(
                                  Icons.photo_album,
                                  size: 55,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          : selectImageLoading
                              ? const CupertinoActivityIndicator()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.memory(
                                    selectedSubCatImage!,
                                    height: 60,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: appcolor1),
                        ),
                        onPressed: () {
                          setState(() {
                            _showDailog = false;
                          });
                        },
                      ),

                      ///------------------------SUBMIT BUTTON----------------------
                      InkWell(
                        onTap: () {
                          if (selectedCategoryId == null) {
                            print('CATEGORY  HAS NULL VALUE');
                          }
                          _addSubCategory(selectedCategoryId!, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: appcolor1,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            'ADD',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 60,
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Future<Uint8List?> _selectSubCategoryImage() async {
    try {
      setState(() {
        selectImageLoading = true;
      });
      final imagepicker = ImagePicker();
      final file = await imagepicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        final selectedImage = await file.readAsBytes();
        setState(() {
          selectedSubCatImage = selectedImage;
          selectImageLoading = false;
        });
        return selectedImage;
      }
    } on PlatformException catch (err) {
      log('ERROR OCCURED !:${err.message}');
      setState(() {
        selectImageLoading = false;
      });

      if (err != null) {
        setState(() {
          selectImageLoading = false;
        });
        showToast(text: err.message!);
      } else {
        setState(() {
          selectImageLoading = false;
        });
        showToast(text: 'Something wrong!try again');
      }
    }

    print('SELECTED CATEGORY IMAGE:$selectedSubCatImage');
  }

  void _addSubCategory(String categoryId, BuildContext context) async {
    final isValid = _formKey.currentState!.validate();

    const uuid = Uuid();

    print('FORM IS VALID:$isValid');

    if (selectedSubCatImage == null) {
      erroetoast('No image selected!');
      return;
    }

    if (isValid == false) {
      erroetoast('Enter a title');
      return;
    }

    if (isValid || selectedSubCatImage != null) {
      //Then Procced Add category

      setState(() {
        submitLoading = true;
      });

      await uploadFirestoreImageServices(selectedSubCatImage!).then((imageUrl) {
        if (imageUrl == null) {
          erroetoast('Image uploading faild!');
          setState(() {
            submitLoading = false;
          });
        }
        final subCatService =
            Provider.of<SubCategoryProvider>(context, listen: false);

        final newSubCat = SubCategoryModel(
            title: addsubCategoryController.text.trim(),
            categoryId: categoryId,
            createdAt: Timestamp.now(),
            image: imageUrl,
            subCategorId: uuid.v1());

        subCatService.addSubCategory(subCategory: newSubCat);
        showToast(text: 'Sub-Category Added');
        addsubCategoryController.clear();
        selectedSubCatImage = null;
        setState(() {
          submitLoading = false;
          _showDailog = false;
        });
      }).catchError((error) {
        log(' ERROR OCCURED!');
        erroetoast(error.toString());
        setState(() {
          submitLoading = false;
        });
      });
    } else {
      setState(() {
        submitLoading = false;
      });
      erroetoast('Something went wrong!try again...');
    }
  }

  _showDeleteDailog() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cancel booking'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure want to cancel booking?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
