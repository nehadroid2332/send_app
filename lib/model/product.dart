// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);


import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sendapp/utils/dbhelper.dart';

class Product extends Equatable {
  final String categoryId;
  final String id;
  final String name;
  final String productId;
  final String description;
  final double quantity;
  final double maxQuantity;
  final double unitPrice;
  final String status;
   int cartQuantity = 1;
   double price;
  final String image;

  get getCartQuantity=>this.cartQuantity;
set setCartQuantity(int i)  {
    if(cartQuantity>=1){
      cartQuantity = cartQuantity+i;
      price = unitPrice*cartQuantity;
      DatabaseHelper db = DatabaseHelper() ;
      db.updateQuantityAndPrice(quantity: cartQuantity.toString(),price: price.toString(),id: this.id);
    }
    print("$cartQuantity and $price");
    }

  Product({
    this.categoryId,
    this.id,
    this.name,
    this.productId,
    this.description,
    this.quantity,
    this.maxQuantity,
    this.unitPrice,
    this.status,
    this.image,
    this.cartQuantity,
    this.price,
  });

  Product copyWith({
    String categoryId,
    String id,
    String name,
    String productId,
    String description,
    int quantity,
    int maxQuantity,
    int unitPrice,
    String status,
    String image,
    int carQuantity,
    double price,
  }) =>
      Product(
        categoryId: categoryId ?? this.categoryId,
        id: id ?? this.id,
        name: name ?? this.name,
        productId: productId ?? this.productId,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        maxQuantity: maxQuantity ?? this.maxQuantity,
        unitPrice: unitPrice ?? this.unitPrice,
        status: status ?? this.status,
        image: image ?? this.image,
        cartQuantity: carQuantity ?? this.cartQuantity,
        price: price ?? this.price,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    categoryId: json["categoryId"],
    id: json["id"],
    name: json["name"],
    productId: json["productId"],
    description: json["description"],
    quantity: double.parse(json["quantity"]) ,
    maxQuantity: double.parse(json["maxQuantity"]) ,
    unitPrice: double.parse(json["unitPrice"]) ,
    status: json["status"],
    image: json["image"],
    cartQuantity: 1,
    price: double.parse(json["unitPrice"]) ,
  );
  factory Product.fromDB(Map<String, dynamic> json) => Product(
    categoryId: json["categoryId"],
    id: json["id"],
    name: json["name"],
    productId: json["productId"],
    description: json["description"],
    quantity: double.tryParse(json["quantity"]) ,
    maxQuantity: double.tryParse(json["maxQuantity"]) ,
    unitPrice: double.tryParse(json["unitPrice"]) ,
    status: json["status"],
    image: json["image"],
    cartQuantity: int.tryParse(json["cartQuantity"]),
    price: double.tryParse(json["price"]) ,
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "id": id,
    "name": name,
    "productId": productId,
    "description": description,
    "quantity": quantity,
    "maxQuantity": maxQuantity,
    "unitPrice": unitPrice,
    "status": status,
    "image": image,
    "price":price,
    "cartQuantity":cartQuantity
  };

  @override
  // TODO: implement props
  List<Object> get props => [id,categoryId,productId,name,status,unitPrice,maxQuantity,quantity,description,];
}
