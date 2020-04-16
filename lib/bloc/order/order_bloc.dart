import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  @override
  OrderState get initialState => InitialOrderState();

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
