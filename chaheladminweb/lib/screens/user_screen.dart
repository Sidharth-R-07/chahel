import 'package:ecommerceadminweb/provider/users_provider.dart';
import 'package:ecommerceadminweb/widgets/user_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController searchController = TextEditingController(text: "+91");
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UsersProvider>(context, listen: false).getFirebaseData(null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Users",
                  style: TextStyle(
                    fontFamily: "pop",
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              //remove search data and get order data
                              Provider.of<UsersProvider>(context, listen: false)
                                  .getFirebaseData(null);
                            }
                          },
                          onSubmitted: (value) {
                            Provider.of<UsersProvider>(context, listen: false)
                                .getSearchcatergory(value);
                          },
                          decoration: InputDecoration(
                            filled: true,
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
                                onPressed: () {
                                  if (searchController.text.isNotEmpty) {
                                    searchController.clear();
                                    Provider.of<UsersProvider>(context,
                                            listen: false)
                                        .getFirebaseData(null);
                                  }
                                },
                                icon: const Icon(Icons.close)),
                            hintText: "Phone number...",
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
                ),
                const SizedBox(
                  width: 200,
                ),
              ],
            ),
          ),
          Expanded(
            child: Provider.of<UsersProvider>(context).isFirebaseDataLoding ==
                    false
                ? Provider.of<UsersProvider>(context).usersList.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 1000,
                              child: CustomScrollView(
                                slivers: [
                                  SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          childCount:
                                              Provider.of<UsersProvider>(
                                                      context)
                                                  .usersList
                                                  .length, (context, index) {
                                    return UserFrame(
                                        userDetails:
                                            Provider.of<UsersProvider>(context)
                                                .usersList[index]);
                                  })),
                                  SliverToBoxAdapter(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Provider.of<UsersProvider>(context)
                                                      .isFirebaseDataLoding ==
                                                  false &&
                                              searchController.text.isEmpty
                                          ? Provider.of<UsersProvider>(context)
                                                      .circularProgressLOading ==
                                                  true
                                              ? Tooltip(
                                                  message: "Get the next list",
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    height: 45,
                                                    width: 45,
                                                    child: MaterialButton(
                                                      elevation: 3,
                                                      color: Colors.white,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          200))),
                                                      onPressed: () {
                                                        if (Provider.of<UsersProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .isNextListDataLoding ==
                                                            false) {
                                                          Provider.of<UsersProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getFirebaseData(
                                                            Provider.of<UsersProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .usersList
                                                                .last
                                                                .lastdoc,
                                                          );
                                                        }
                                                      },
                                                      child: Provider.of<UsersProvider>(
                                                                      context)
                                                                  .isNextListDataLoding ==
                                                              false
                                                          ? const Icon(
                                                              CupertinoIcons
                                                                  .add,
                                                              color:
                                                                  Colors.black,
                                                              size: 22,
                                                            )
                                                          : const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
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
                                              : Container()
                                          : Container(),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          searchController.text.isEmpty
                              ? "  There are currently no users..."
                              : 'No results found for "${searchController.text}" ',
                          style: const TextStyle(fontFamily: "pop"),
                        ),
                      )
                : const CupertinoActivityIndicator(),
          )
        ],
      ),
    );
  }
}
