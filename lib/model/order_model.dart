// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final String userId;
  final String price;
  final String addressId;
  final String deliveryDate;
  final String deliveryTime;
  final List<ItemList> itemList;

  OrderModel({
    this.userId,
    this.price,
    this.addressId,
    this.deliveryDate,
    this.deliveryTime,
    this.itemList,
  });

  OrderModel copyWith({
    String userId,
    String price,
    String addressId,
    String deliveryDate,
    String deliveryTime,
    List<ItemList> itemList,
  }) =>
      OrderModel(
        userId: userId ?? this.userId,
        price: price ?? this.price,
        addressId: addressId ?? this.addressId,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        itemList: itemList ?? this.itemList,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    userId: json["userId"],
    price: json["price"],
    addressId: json["addressId"],
    deliveryDate: json["deliveryDate"],
    deliveryTime: json["deliveryTime"],
    itemList: List<ItemList>.from(json["itemList"].map((x) => ItemList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "price": price,
    "addressId": addressId,
    "deliveryDate": deliveryDate,
    "deliveryTime": deliveryTime,
    "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
  };
}

class ItemList {
  final String itemId;
  final String quantity;
  final String total;

  ItemList({
    this.itemId,
    this.quantity,
    this.total,
  });

  ItemList copyWith({
    String itemId,
    String quantity,
    String total,
  }) =>
      ItemList(
        itemId: itemId ?? this.itemId,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
      );

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    itemId: json["itemId"],
    quantity: json["quantity"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "quantity": quantity,
    "total": total,
  };
}
