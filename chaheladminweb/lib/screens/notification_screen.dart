
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_details.dart';
import 'package:ecommerceadminweb/widgets/custom_circular_progress.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/image_pick.provider.dart';
import '../services/upload_firestore_image_services.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Uint8List? image;
  TextEditingController notificationTitle=TextEditingController();
  TextEditingController notificationcontent =TextEditingController();
  GlobalKey key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
          SliverAppBar(
      scrolledUnderElevation: 5,
      elevation: 10,
      pinned: true,
      backgroundColor: Colors.white,
          title: Row(
           
            children:const [
              Text("Sent notification",style: TextStyle(
                fontFamily: "pop",
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),),
           
               
            ],
          ),
       
      ), 
      SliverPadding(
        padding:const EdgeInsets.all(20),
        sliver: SliverList(delegate:SliverChildListDelegate(
                  [
                  const Text("It is not mandatory to provide the image while you are making the notification."),
                  const SizedBox(
                    height: 20,
                  ),
                     Row(
                       children: [
                         InkWell(
                            onTap: () async {
                              final pickimage =
                                  await Provider.of<CustomPickImageProvider>(
                                          context,
                                          listen: false)
                                      .pickimage();
                              if (pickimage == null) return;
                              image = pickimage;
                              setState(
                                () {},
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                  padding: EdgeInsets.zero,
                                  height: 200,
                                  width: 200,
                                  color: Colors.white,
                                  child: image != null
                                      ? Image.memory(
                                          image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.add),
                                            Text("Add image"),
                                          ],
                                        )),
                            ),
                          ),
                       ],
                     ),
                     const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: CustomTextfield(controller: notificationTitle,
                    labelText: "Enter notification title",
                    
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: CustomTextfield(controller: notificationcontent,
                    labelText: "Enter notification content",
                     maxLines: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                      Row(
                        children: [
                          MaterialButton(
                            color: uploadButtonColors,
                            height: 50,
                            onPressed: ()async{
                              if (notificationTitle.text.isEmpty) {
                                erroetoast("Please enter notification title.");
                              }else if(notificationcontent.text.isEmpty){
                                erroetoast("Please enter notification content.");
                              }else{
                              customCircularProgressIndicator(context, key);
                              final isNotification=  await callOnFcmApiSendPushNotifications(title: notificationTitle.text, body: notificationcontent.text);
                              notificationTitle.clear();
                              notificationcontent.clear();
                              image=null;
                              setState(() {
                                
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              if (isNotification) {
                                saccesstoast("Notification sent successfully.");
                              }
                              }
                            
                            },
                            child:const Text("Sent",style: TextStyle(
                  fontFamily: "pop",
                  color: Colors.black,
                ),),),
                        ],
                      ),
                  ]
                ), ),
             
         
      ),
      ],
    );
  }
   Future<bool> callOnFcmApiSendPushNotifications(
      {required String title, required String body}) async {
        String? url;
      if (image!=null) {
            url =await uploadFirestoreImageServices(image!);
         }
     FirebaseFirestore.instance.collection("notification").doc().set(
      {
        "image":url,
        "msg":body,
        "title":title,
        "timestamp":Timestamp.now(),
      }
     );

    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      //"to":"c2RcOpTyTdiSrsCyZbPkXC:APA91bFYQ6dNQe039tzLpMNuAoNblvSQIKsuuc7ZgoeWkQgqaJnkWuI4y3YJ9LIGstFoPtdLJal1TpSbVAckhy9eXVAa2bK9NDlMUUie7dpTDZZFcI7VJDstY_S8NMqnpGQf6Ae2C6yn",
      "to": "/topics/admin",
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "priority": "high",
      "notification": {
        "title": title,
        "body": body,
        "content_available": true,
       // "sound":"order.mp3",
        //"playSound": true,
        "android_channel_id": "notification_channel_fcm",
        "image": "$url"
      },
      "data": {
        // "type": '0rder',
        // "id": '28',
        // "click_action": 'FLUTTER_NOTIFICATION_CLICK',
       
      },
      "apns":{ 
      "headers":{
         "apns-priority":"10",
         "apns-push-type":"background",
     
      },
      "payload":{
         "aps":{
            "content-available":1
         }
      }
   }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=$notificationKey' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);
       //   log(response.body);
    if (response.statusCode == 200) {
      // on success do sth
     // print('test ok push CFM');
      return true;
    } else {
     // print(' CFM error');
      // on failure do sth
      return false;
    }
  }
}