import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sendapp/services/cart_repo.dart';
import 'package:sendapp/services/categories_repo.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesRepository _repo;
  final CartRepo cartRepo;

  CategoryBloc({@required CategoriesRepository repo,@required CartRepo catRepo}):assert(repo!=null),this._repo=repo,this.cartRepo = catRepo;

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    // TODO: Add Logic
    if(event is LoadCategories){
      yield* _mapLoadCategoryToState();
    }
  }

  Stream<CategoryState> _mapLoadCategoryToState() async*{
    try {
      yield CategoryLoading();
      final categories = await _repo.getCategories();
      yield CategoryLoaded(categories: categories);
    } catch (e) {
      yield  CategoryLoadingFail(reason:e.toString());
    }

  }
}
