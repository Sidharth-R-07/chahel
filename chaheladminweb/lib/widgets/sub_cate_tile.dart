// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:ecommerceadminweb/models/sub_category_model.dart';

import 'custom_network_image.dart';

class SubCatTile extends StatelessWidget {
  final SubCategoryModel subCategory;

  final Function() editeFn;
  final Function() deleteFn;

  final Function() onTap;
  SubCatTile({
    Key? key,
    required this.subCategory,
    required this.editeFn,
    required this.deleteFn,
    required this.onTap,
  }) : super(key: key);

  int onSelected = 0;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(3),
        title: Text(
          subCategory.title!,
          overflow: TextOverflow.ellipsis,
        ),
        leading: SizedBox(
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomNetworkImage(
                imageUrl: subCategory.image!, fit: BoxFit.contain),
            // ),
          ),
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: (value) {
            if (value == 1) {
              editeFn();
            } else if (value == 2) {
              deleteFn();
            }
          },
          tooltip: 'more',
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Text('edit'),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text('delete'),
            )
          ],
        ));
  }
}
