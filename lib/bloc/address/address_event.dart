import 'package:equatable/equatable.dart';
import 'package:sendapp/model/address.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class AddAddress extends AddressEvent{
  final String name;
  final String address;
  final String postalCode;

  AddAddress({this.postalCode,this.address,this.name,});
  @override
  // TODO: implement props
  List<Object> get props => [address,address,postalCode,name];
}