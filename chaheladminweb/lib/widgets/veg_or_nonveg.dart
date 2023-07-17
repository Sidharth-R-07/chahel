import 'package:flutter/material.dart';

class VEGorNONVEG extends StatelessWidget {
  const VEGorNONVEG({Key? key, required this.isVEG,required this.isText, this.size}) : super(key: key);
  final bool? isVEG;
  final bool isText;
  final double? size;
  @override
  Widget build(BuildContext context) {
    if (isVEG == true) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            height: size??20,
            width: size??20,
            
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(color: Colors.green, width: 2)),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
           if (isText)
         const  Text(
            "Veg",
            style:TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      );
    } else if (isVEG == false) {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            height: size??20,
            width: size??20,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(color: Colors.red, width: 2)),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          if (isText) 
          const Text(
            "Non Veg",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
