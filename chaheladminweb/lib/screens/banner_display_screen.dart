import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/models/banner_model.dart';
import 'package:ecommerceadminweb/screens/banner_edit_screen.dart';
import 'package:ecommerceadminweb/screens/banner_product_display_screen.dart';
import 'package:ecommerceadminweb/screens/banner_products_add_screen.dart';
import 'package:ecommerceadminweb/screens/banner_upload_screen.dart';
import 'package:ecommerceadminweb/widgets/banner_frame.dart';
import 'package:ecommerceadminweb/widgets/custom_popup.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerDisplayScreen extends StatefulWidget {
  const BannerDisplayScreen({super.key});

  @override
  State<BannerDisplayScreen> createState() => _BannerDisplayScreenState();
}

class _BannerDisplayScreenState extends State<BannerDisplayScreen> {
  List<BannerModel> bannerList = [];
  bool getFirebasegetData = false;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        scrolledUnderElevation: 5,
        elevation: 10,
        pinned: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              if (getFirebasegetData) {
                if ((bannerList.length) == 10) {
                  erroetoast(
                      "The maximum number of banners that can be placed is '10'");
                } else {
                  showDialogAddBanner(context);
                }
              } else {
                normeltoast("Please wait.");
              }
            },
            icon: const Icon(Icons.add),
            tooltip: "add banner",
            color: Colors.black,
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          sliver: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("banner")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  bannerList = [];
                  getFirebasegetData = true;
                  Future.delayed(Duration.zero, () {});

                  for (QueryDocumentSnapshot<Map<String, dynamic>> element
                      in snapshot.data?.docs ?? []) {
                    bannerList.add(
                      BannerModel(
                        image: element.data()["image"],
                        bannerID: element.id,
                      ),
                    );
                  }

                  return bannerList.isNotEmpty
                      ? SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3 / 2),
                          delegate: SliverChildBuilderDelegate(
                            childCount: bannerList.length,

                            ///
                            (context, index) {
                              return BannerFrame(
                                bannerDetails: bannerList[index],
                                addProducts: () {
                                  showDialogAddBannerProducts(
                                      context, bannerList[index]);
                                },
                                viewproducts: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BannerProductDisplayScreen(
                                          bannerdetails: bannerList[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                edit: () {
                                  showDialogEditBanner(
                                      context, bannerList[index]);
                                },
                                delete: () {
                                  customPoPup(
                                      context, "Delete", "Delete this banner",
                                      () {
                                    FirebaseFirestore.instance
                                        .collection("banner")
                                        .doc(bannerList[index].bannerID)
                                        .delete();

                                    Navigator.pop(context);
                                  }, "OK");
                                },
                              );
                            },
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                              ),
                              const Center(
                                child: Text(
                                  "Banner is empty...     ",
                                  style: TextStyle(
                                    fontFamily: "pop",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                } else {
                  return SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.5,
                        ),
                        const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ],
                    ),
                  );
                }
              })),
    ]);
  }
}
