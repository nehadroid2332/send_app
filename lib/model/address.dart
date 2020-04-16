
import 'package:equatable/equatable.dart';

class Address extends Equatable{
  final String userId;
  final String type;
  final String address;
  final String postalCode;
  final String isDefault;
  final String status;
  final String lat;
  final String long;
  final String id;

  Address({
    this.userId,
    this.type,
    this.address,
    this.postalCode,
    this.isDefault,
    this.status,
    this.lat,
    this.long,
    this.id,
  });

  Address copyWith({
    String userId,
    String type,
    String address,
    String postalCode,
    String isDefault,
    String status,
    String lat,
    String long,
    String id,
  }) =>
      Address(
        userId: userId ?? this.userId,
        type: type ?? this.type,
        address: address ?? this.address,
        postalCode: postalCode ?? this.postalCode,
        isDefault: isDefault ?? this.isDefault,
        status: status ?? this.status,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        id: id ?? this.id,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    userId: json["userId"],
    type: json["type"],
    address: json["address"],
    postalCode: json["postalCode"],
    isDefault: json["isDefault"],
    status: json["status"],
    lat: json["lat"],
    long: json["long"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "type": type,
    "address": address,
    "postalCode": postalCode,
    "isDefault": isDefault,
    "status": status,
    "lat": lat,
    "long": long,
    "id": id,
  };

  @override
  // TODO: implement props
  List<Object> get props => [userId,type,address,postalCode,status,lat,long,id];
}
