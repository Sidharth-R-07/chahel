import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/widgets/custom_textfield.dart';
import 'package:ecommerceadminweb/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  TextEditingController chargeEditingController =TextEditingController();
  TextEditingController freedeliveryaboveEditingController =TextEditingController();
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
              Text("Set up delivery",style: TextStyle(
                fontFamily: "pop",
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),),
           
               
            ],
          ),
       
      ),
      SliverPadding(
        padding:const EdgeInsets.all(20),
        sliver: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream:  FirebaseFirestore.instance.collection("general").doc("delivery").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.active) {
              chargeEditingController.text=snapshot.data?.data()?["charge"]??"0";
              freedeliveryaboveEditingController.text=snapshot.data?.data()?["freeAbove"]??"0";
                return SliverList(delegate:SliverChildListDelegate(
                  [
                  const Text("You should be careful while setting the delivery charge as the delivery charge is not calculated based on the distance in kilometers."),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: CustomTextfield(
                      
                      controller: chargeEditingController,
                     inputFormatters:  [FilteringTextInputFormatter.digitsOnly],
                    labelText: "Delivery charge per order *",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                     SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: CustomTextfield(
                      
                      controller: freedeliveryaboveEditingController,
                     inputFormatters:  [FilteringTextInputFormatter.digitsOnly],
                    labelText: "Free delivery above",
                    ),
                  ),
                    const SizedBox(
                    height: 20,
                  ),
                  int.parse(freedeliveryaboveEditingController.text.isNotEmpty?freedeliveryaboveEditingController.text:"0")>0?
                  Text("${chargeEditingController.text} will be charged on all orders below ${freedeliveryaboveEditingController.text}"):const SizedBox(),
                    const SizedBox(
                    height: 20,
                  ),
                      Row(
                        children: [
                          MaterialButton(
                            color: uploadButtonColors,
                            height: 50,
                            onPressed: (){
                              if (chargeEditingController.text.isEmpty) {
                                erroetoast("Please enter delivery charge.");
                              }else{
                                FirebaseFirestore.instance.collection("general").doc("delivery").set(
                                  {
                                    "charge":chargeEditingController.text.isNotEmpty?
                                    chargeEditingController.text:0,
                                    "freeAbove":freedeliveryaboveEditingController.text.isNotEmpty?
                                    freedeliveryaboveEditingController.text:"0"
                                    ,
                                  }
                                );
                                saccesstoast("Delivery details added successfully.");
                              }
                            },
                            child:const Text("Add",style: TextStyle(
                  fontFamily: "pop",
                  color: Colors.black,
                ),),),
                        ],
                      ),
                  ]
                ), );
              }else{
                 return  SliverToBoxAdapter(
                  child: Column(
                    children: [
                          SizedBox(
                        height: MediaQuery.of(context).size.height/2.5,
                      ),
                     const Center(
                        child: CupertinoActivityIndicator(),)
                    ],
                  ),
                 );
              }
          }
        ),
      ),
      ],
    );
  }
  
}