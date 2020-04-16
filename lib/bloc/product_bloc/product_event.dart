import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}
class LoadProducts extends ProductEvent{
  final String id;

  LoadProducts({this.id});
  @override
  // TODO: implement props
  List<Object> get props => [id];
}