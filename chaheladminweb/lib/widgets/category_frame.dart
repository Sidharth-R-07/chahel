import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/catergory_model.dart';

import 'package:flutter/material.dart';

import 'shimmer.dart';

class CategoryFrame extends StatelessWidget {
  const CategoryFrame(
      {super.key,
      required this.categoryDetails,
      required this.delete,
      required this.edit});
  final CategoryModel categoryDetails;
  final Function edit;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 1100,
          color: Colors.white,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  height: 65,
                  width: 65,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: categoryDetails.image,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CustomShimmer(
                          radius: 10,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 65,
                        width: 65,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.2),
                                ])),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                categoryDetails.name,
                style: const TextStyle(
                    fontFamily: "pop",
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis),
              ),
              const Spacer(),
              PopupMenuButton<int>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                onSelected: ((value) {
                  if (value == 0) {
                    edit.call();
                  } else {
                    delete.call();
                  }
                }),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0, //---add this line

                    // row has two child icon and text
                    child: Row(
                      children: const [
                        Icon(Icons.edit),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Edit")
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    // row has two child icon and text
                    child: Row(
                      children: const [
                        Icon(Icons.delete),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Delete"),
                      ],
                    ),
                  ),
                ],
                //  offset: Offset(0, 100),
                color: Colors.white,
                elevation: 5,
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}



// Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           Card(
//                             margin: EdgeInsets.zero,
//                             shape:const RoundedRectangleBorder(
//                                borderRadius: BorderRadius.all(Radius.circular(10)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius:const BorderRadius.all(Radius.circular(10)),
//                               child:  CachedNetworkImage(
//                 imageUrl: categoryDetails.image,
//                 progressIndicatorBuilder: (context, url, downloadProgress) =>
//                     const CustomShimmer(
//                   radius: 10,
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//                 fit: BoxFit.cover,
//               ),
                 
//                             ),
//                           ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius:const BorderRadius.all(Radius.circular(10)),
                          //     gradient: LinearGradient(
                          //        begin: Alignment.centerRight,
                          //           end: Alignment.centerLeft,
                          //       colors: [
                                 
                          //       Colors.transparent, Colors.black.withOpacity(0.4),
                          //     ])
                          //   ),
                          // ),
//                               Padding(
//                 padding: const EdgeInsets.only(left: 5, right: 0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Card(
//                       elevation: 0,
//                       shape:const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(100)),
//                       ),
//                       color: Colors.black.withOpacity(.1),
//                       child: PopupMenuButton<int>(
//                         shape:const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20),),
//                         ),
                        // onSelected: ((value) {
                        //   if (value == 0) {
                        //     edit.call();
                          
                        //   }else{
                        //     delete.call();
                        //   }
                        // }),
                        // itemBuilder: (context) => [
                        //   PopupMenuItem(
                        //     value: 0, //---add this line
                    
                        //     // row has two child icon and text
                        //     child: Row(
                        //       children: const [
                        //         Icon(Icons.edit),
                        //         SizedBox(
                        //           // sized box with width 10
                        //           width: 10,
                        //         ),
                        //         Text("Edit")
                        //       ],
                        //     ),
                        //   ),
                        //   PopupMenuItem(
                           
                        //     value: 2,
                        //     // row has two child icon and text
                        //     child: Row(
                        //       children: const [
                        //         Icon(Icons.delete),
                        //         SizedBox(
                        //           // sized box with width 10
                        //           width: 10,
                        //         ),
                        //         Text("Delete"),
                        //       ],
                        //     ),
                        //   ),
                        // ],
//                         //  offset: Offset(0, 100),
//                         color: Colors.white,
//                         elevation: 5,
//                         icon: const Icon(
//                           Icons.more_vert_outlined,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "${categoryDetails.name}",
//                             style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w800,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                   ],
//                 ),
//               ),
//                         ],
//                       );