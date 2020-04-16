import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class InitialOrderState extends OrderState {
  @override
  List<Object> get props => [];
}
