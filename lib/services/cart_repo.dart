import 'package:flutter/material.dart';
import 'package:sendapp/model/product.dart';
import 'package:sendapp/utils/dbhelper.dart';

class CartRepo {
  //list of ptoduct
List<Product> _products = [];
DatabaseHelper db = DatabaseHelper();


  Future<List<Product>> get getProducts async {
    return /*_products.isNotEmpty?_products:*/await db.getProductsList();
  }

//? add product
 @protected set product(Product product) {
      _products.add(product);
  }

 Future<String> addProduct(Product product)async{
   if(await db.checkProduct(product.id)){
     return "Item Already In cart";
   }
   db.addProductToDb(product);
   return "Item Added to cart";
  }

//? price of all product
 Future<double> getTotal()async {
   List list = await db.getProductsList();
   double price  = list.fold(0, (previousValue, element) => previousValue+element.price.toInt());
   return price;
  }


//? delete product
deleteProduct(Product product)async{
await db.deleteProduct(product.id);
}


Product checkProduct(Product product){
  if(_products.contains(product)){
  return _products.firstWhere((element) => element == product);
  }
  return null;
}

}