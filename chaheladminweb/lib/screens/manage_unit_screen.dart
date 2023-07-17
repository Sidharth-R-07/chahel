import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadminweb/general/app_colors.dart';
import 'package:ecommerceadminweb/provider/product_unit_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void manageUnitscreen(context){
   showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20),),
          ),
          title:const  Text("Manage unit."),
          content: SizedBox(
            height: 200,
            width: 200,
            child:Provider.of<ProductUnitProvider>(context).isFirebaseLoding==false?
            Provider.of<ProductUnitProvider>(context).productunitList.isNotEmpty?
             ListView.builder(
              shrinkWrap: true,
              itemCount: Provider.of<ProductUnitProvider>(context).productunitList.length,
              itemBuilder: (context,index){
              return Card(
                elevation: 2,
                child: Container(
                  padding:const EdgeInsets.all(5),
                  height: 50,
                        
                  child: Row(
                    children: [
                      Expanded(child: Text(Provider.of<ProductUnitProvider>(context).productunitList[index],overflow: TextOverflow.ellipsis,),),
                      IconButton(onPressed: (){
                           Provider.of<ProductUnitProvider>(context,listen: false).productunitList.removeAt(index);
                          FirebaseFirestore.instance.collection("general").doc("units").set(
                              {
                                "unitList": Provider.of<ProductUnitProvider>(context,listen: false).productunitList,
                              }
                            );
                      }, icon:const Icon(Icons.close),),
                    ],
                  )),
              );
            },):
               const Center(
                          child: Text("Unit is empty...",style: TextStyle(
                            fontFamily: "pop",
                            color: Colors.black,
                          ),),
                        )
            :const Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
       
        );
      });
}