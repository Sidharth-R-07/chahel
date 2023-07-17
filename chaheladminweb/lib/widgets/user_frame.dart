import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceadminweb/models/user_details_model.dart';
import 'package:ecommerceadminweb/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class UserFrame extends StatelessWidget {
  const UserFrame({super.key, required this.userDetails});
  final UserDetailsModel userDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 240,
      width: 1000,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 240,
            width: 240,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //                   <--- right side
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: userDetails.userImage != null
                        ? Colors.white
                        : Colors.indigo.shade50,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: userDetails.userImage != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: userDetails.userImage ?? "",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const CustomShimmer(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          IconlyLight.profile,
                          color: Colors.indigo.shade100,
                          size: 30,
                        ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    userDetails.name,
                    style: const TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 80,
                width: 720,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 335,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            // text: "By continuing you agree to $appname's",
                            children: [
                              const TextSpan(
                                text: "Mobile:  ",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: userDetails.phoneNumber,
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 335,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            // text: "By continuing you agree to $appname's",
                            children: [
                              const TextSpan(
                                text: "House No / Building name:  ",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: userDetails.houseNoBuilding ?? "-----",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 720,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 335,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            // text: "By continuing you agree to $appname's",
                            children: [
                              const TextSpan(
                                text: "Road Name / Area / Colony:  ",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: userDetails.roadname ?? "-----",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 335,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            // text: "By continuing you agree to $appname's",
                            children: [
                              const TextSpan(
                                text: "Pincode:  ",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: userDetails.pincode ?? "-----",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 720,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 335,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            // text: "By continuing you agree to $appname's",
                            children: [
                              const TextSpan(
                                text: "City:  ",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: userDetails.city ?? "-----",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 335,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                            // text: "By continuing you agree to $appname's",
                            children: [
                              const TextSpan(
                                text: "State:  ",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: userDetails.state ?? "-----",
                                style: TextStyle(
                                    fontFamily: "pop",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
