

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  String name;
  String phoneNumber;
  String? pincode;
  String? state;
 
  String? city;
  String? houseNoBuilding;
  String? roadname;
  bool? ishome;
  
  //
  String? userImage;
  String? userID;
  //
  QueryDocumentSnapshot<Map<String, dynamic>>? lastdoc;

  UserDetailsModel(
      {required this.name,
      required this.phoneNumber,
       this.city,
       this.houseNoBuilding,
       this.ishome,
       this.pincode,
       this.roadname,
       this.state,
       this.userID,
      this.userImage,
      this.lastdoc,
     });
}
