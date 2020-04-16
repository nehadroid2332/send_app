import 'package:equatable/equatable.dart';
import 'package:sendapp/model/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class InitialProductState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class ProductLoaded extends ProductState{
  final List<Product> products;

  ProductLoaded({this.products});

  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class ProductLoadingFail extends ProductState{
  final String reason;

  ProductLoadingFail({this.reason});

  @override
  // TODO: implement props
  List<Object> get props => [reason];
}
