import 'dart:async';
import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:sendapp/services/user_repo.dart';
import './bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final UserRepo repo;

  AddressBloc({this.repo});
  @override
  AddressState get initialState => InitialAddressState();

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is AddAddress){
      yield* _mapAddAddressToState(event);
    }
  }

  Stream<AddressState> _mapAddAddressToState(AddAddress event)async*{
    try {
      yield AddressLoading();
    var address =  await repo.addUserAddress(address:event.address,name: event.name,pinCode: event.postalCode);

      repo.orderModel = repo.orderModel?.copyWith(addressId: address.id);
      yield AddressAdded();
    } catch (e) {
      yield AddressLoadingFail(reason: e.toString());
    }
  }
}
