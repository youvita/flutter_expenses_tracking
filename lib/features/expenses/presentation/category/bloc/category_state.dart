part of 'category_bloc.dart';

class CategoryState extends Equatable {

  const CategoryState({
    this.categories,
  });

  final Categories? categories;

  CategoryState copyWith({
    Categories? categories,
  }) {
    return CategoryState(
        categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [categories];
}

class CategoryInitial extends CategoryState {}
