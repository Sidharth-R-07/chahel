
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel{
  List<OfferAndIdModel> offerAndIdList;
  String name;
  String offerID;
  int designNumber;
  OfferModel({required this.offerAndIdList,required this.name,required this.offerID,required this.designNumber});
}


class OfferAndIdModel{
  String image;
  String iD;
  Timestamp? timestamp;
  OfferAndIdModel({required this.image,required this.iD,this.timestamp});

  compareTo(Timestamp? timestamp) {}
}


class UplodOfferAndIdModel{
  Uint8List image;
  String iD;
  UplodOfferAndIdModel({required this.image,required this.iD});
}