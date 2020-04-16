import 'package:equatable/equatable.dart';
import 'package:sendapp/model/address.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class InitialAddressState extends AddressState {
  @override
  List<Object> get props => [];
}
class AddressAdded extends AddressState{
  final Address address;

  AddressAdded({this.address});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AddressLoading extends AddressState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddressLoadingFail extends AddressState{
  final String reason;

  AddressLoadingFail({this.reason});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

