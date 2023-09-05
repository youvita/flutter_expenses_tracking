part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryImageChanged extends CategoryEvent {
  const CategoryImageChanged(this.categoryImage);

  final String categoryImage;

  @override
  List<Object> get props => [categoryImage];
}

class CategoryNameChanged extends CategoryEvent {
  const CategoryNameChanged(this.categoryName);

  final String categoryName;

  @override
  List<Object> get props => [categoryName];
}

class CategoriesState extends CategoryEvent {
  const CategoriesState();
}
