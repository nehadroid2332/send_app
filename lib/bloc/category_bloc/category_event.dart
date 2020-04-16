import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategories extends CategoryEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}