
import 'package:flutter/cupertino.dart';

import '../models/product_parameters_model.dart';

class ProductParametersProvider extends ChangeNotifier{
  List<ProductParametersModel> productParametersList=[];

  void addProductParametersBox(){
    productParametersList.add(
      ProductParametersModel(
         
        
      ),
      
    );
    
      Future.delayed(Duration.zero,(){
        notifyListeners();
       //your code goes here
  });
 
  }
  void removeProductParametersBox(int index){
    
    productParametersList.removeAt(index);
    
           Future.delayed(Duration.zero,(){
        notifyListeners();
       //your code goes here
  });


   
  }
  void clearData(){
    productParametersList=[];
    if (productParametersList.isEmpty) {
      productParametersList.add(
      ProductParametersModel(
         
        
      ),
      
    ); 
    }
    notifyListeners();
  }


}