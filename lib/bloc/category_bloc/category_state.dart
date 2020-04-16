import 'package:equatable/equatable.dart';
import 'package:sendapp/model/category.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class InitialCategoryState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class CategoryLoaded extends CategoryState{
  final List<Category> categories;

  CategoryLoaded({this.categories});

  @override
  // TODO: implement props
  List<Object> get props => [categories];
}

class CategoryLoadingFail extends CategoryState{
  final String reason;

  CategoryLoadingFail({this.reason});

  @override
  // TODO: implement props
  List<Object> get props => [reason];
}
