import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sendapp/services/categories_repo.dart';
import './bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CategoriesRepository _repository;

  ProductBloc({CategoriesRepository repo}):this._repository = repo??CategoriesRepository();
  @override
  ProductState get initialState => InitialProductState();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is LoadProducts){
      yield* _mapLoadProductsToState(event);
    }
  }

  Stream<ProductState> _mapLoadProductsToState(LoadProducts event)async*{
    try {
      yield ProductLoading();
      final products =  await _repository.getProductById( productId:event.id );
      yield ProductLoaded(products: products);
    } catch (e) {
      print(e);
      yield ProductLoadingFail(reason: e.toString());
    }

  }

}
