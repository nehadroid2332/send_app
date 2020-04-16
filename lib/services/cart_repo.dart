import 'package:flutter/material.dart';
import 'package:sendapp/model/product.dart';

class CartRepo {
  //list of ptoduct
List<Product> _products = [];

  List<Product> get getProducts => _products;

//? add product
 @protected set product(Product product) {
      _products.add(product);
  }

 String addProduct(Product product){
   if(_products.contains(product)){
     return "Item Already In cart";
   }
   this._products.add(product);
   print(product);
   print(_products.length);
   return "Item Added to cart";
  }

//? price of all product
  getTotal(){
   int price  = _products.fold(0, (previousValue, element) => previousValue+element.price.toInt());
   return price;
  }


//? delete product
deleteProduct(Product product){
_products.remove(product);
}


Product checkProduct(Product product){
  if(_products.contains(product)){
  return _products.firstWhere((element) => element == product);
  }
  return null;
}

}