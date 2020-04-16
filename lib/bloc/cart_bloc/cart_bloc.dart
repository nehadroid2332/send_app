import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => InitialCartState();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
