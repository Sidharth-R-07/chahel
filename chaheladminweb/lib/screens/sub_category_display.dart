import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/get_catergory_provider.dart';

class SubCategoryDisplay extends StatefulWidget {
  final String categoryId;
  final Function() hideContainerFn;
  const SubCategoryDisplay(
      {super.key, required this.categoryId, required this.hideContainerFn});

  @override
  State<SubCategoryDisplay> createState() => _SubCategoryDisplayState();
}

class _SubCategoryDisplayState extends State<SubCategoryDisplay> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * .70,
        width: size.height * .80,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        Provider.of<GetCatergoryProvider>(context,
                                listen: false)
                            .getSearchcatergory(value);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Search sub category...",
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
                                await Provider.of<GetCatergoryProvider>(context,
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
                  IconButton(
                      onPressed: widget.hideContainerFn,
                      icon: const Icon(Icons.close))
                ],
              ),
            ],
          ),
        ));
  }
}
