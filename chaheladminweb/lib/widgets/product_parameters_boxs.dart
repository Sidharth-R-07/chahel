
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerceadminweb/widgets/creat_unit_box.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../models/product_parameters_model.dart';
import '../provider/product_unit_provider.dart';

class ProductParametersBoxs extends StatefulWidget {
  const ProductParametersBoxs({super.key,
   required this.customProductDetails});
  final ProductParametersModel customProductDetails;

  @override
  State<ProductParametersBoxs> createState() => _ProductParametersBoxsState();
}

class _ProductParametersBoxsState extends State<ProductParametersBoxs> { 
    //TextEditingController measurement=TextEditingController();
    TextEditingController mrp=TextEditingController();
    TextEditingController rs=TextEditingController();
    TextEditingController stock=TextEditingController();
   //static final TextInputFormatter digitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));


String? selectedValue;

  @override
  Widget build(BuildContext context) {

        // measurement=TextEditingController(text: widget.customProductDetails.measurement);
    mrp= ((widget.customProductDetails.mrp??0)>0)? TextEditingController(text: "${widget.customProductDetails.mrp??""}"):TextEditingController(text: "");
    rs=TextEditingController(text: "${widget.customProductDetails.rs??""}");
    stock=TextEditingController(text: "${widget.customProductDetails.stock??""}");
    return Column(
      children: [
      
  
        Row(
          children: [
     
            //
           const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 35,
                child:Provider.of<ProductUnitProvider>(context).isFirebaseLoding==false?
                 Provider.of<ProductUnitProvider>(context).productunitList.isNotEmpty?
                 DropdownButtonHideUnderline(
                  
          child: DropdownButton2(
                
                buttonPadding:const EdgeInsets.only(left: 5),
                buttonDecoration: BoxDecoration(
                  border: Border.all(
                    width: .5,
                    color:const Color.fromARGB(255, 99, 98, 98),
                  ),
                ),
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme
                            .of(context)
                            .hintColor,
                  ),
                ),

                items: Provider.of<ProductUnitProvider>(context).productunitList
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                value: widget.customProductDetails.uint,
                onChanged: (value) {
                widget.customProductDetails.uint=value;
                setState(() {
                  
                });
                },
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
          ),
        ):
        MaterialButton(
          color: Colors.white,
          elevation: 2,
          child: const Text("Please add unit."),onPressed: (){
            creatUnit(context);
          })
        :Shimmer.fromColors( baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade100,
                        period: const Duration(milliseconds: 500),
                        child: Container(
                          height: 37,
                          width: 140,
                          color: Colors.white,
                        )),
              ),
            ),
         const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "MRP (₹):",
                    style: TextStyle(fontFamily: "pop"),
                  ),
                  SizedBox(
                    height: 35,
                    
                    child: TextField(
                      controller: mrp,
                       keyboardType: TextInputType.number,
                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                      widget.customProductDetails.mrp=double.parse(value.isNotEmpty?value:"0");
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                        EdgeInsets.only(top: 20, left: 10, right: 5),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color.fromARGB(255, 3, 48, 85),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(width: 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           const SizedBox(
              width: 10,
            ),
                 Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rs (₹): *",
                    style: TextStyle(fontFamily: "pop"),
                  ),
                  SizedBox(
                    height: 35,
                    
                    child: TextField(
                      controller: rs,
                       keyboardType: TextInputType.number,
                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                        widget.customProductDetails.rs=double.parse(value.isNotEmpty?value:"0");
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 20, left: 10, right: 5),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color.fromARGB(255, 3, 48, 85),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(width: 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           const SizedBox(
              width: 10,
            ),
               Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Stock: *",
                    style: TextStyle(fontFamily: "pop"),
                  ),
                  SizedBox(
                    height: 35,
                    
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: stock,
                        onChanged: (value) {
                        widget.customProductDetails.stock=int.parse(value.isNotEmpty?value:"0");
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 20, left: 10, right: 5),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color.fromARGB(255, 3, 48, 85),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(width: 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
          ],
        ),
        const SizedBox(
              height: 20,
            ),
       const Divider(thickness: 1),
      ],
    );
  }
}
