part of 'category_bloc.dart';

class CategoryState extends Equatable {

  const CategoryState({
    this.categories,
    this.image,
    this.name
  });

  final Categories? categories;
  final String? image;
  final String? name;

  CategoryState copyWith({
    Categories? categories,
    String? image,
    String? name
  }) {
    return CategoryState(
        categories: categories ?? this.categories,
        image: image ?? this.image,
        name: name ?? this.name
    );
  }

  @override
  List<Object?> get props => [categories, image, name];
}

class CategoryInitial extends CategoryState {}
