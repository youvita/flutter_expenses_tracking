import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase _useCase;

  CategoryBloc({required CategoryUseCase useCase}) : _useCase = useCase, super(CategoryInitial()) {
    on<CategoryEvent>(_fetchCategories);
  }

  Future<void> _fetchCategories(CategoryEvent event, Emitter<CategoryState> emit) async {
    final categories = await _useCase.getCategories();
    print("bloc:: $categories");
    emit(
        state.copyWith(
            categories: categories
        )
    );
  }

}
