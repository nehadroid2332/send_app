import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class InitialCartState extends CartState {
  @override
  List<Object> get props => [];
}
