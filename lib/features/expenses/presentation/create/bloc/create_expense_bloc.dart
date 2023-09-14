import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_tracking/config/date_util.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/create_usecase.dart';
import 'package:intl/intl.dart';

import '../../../data/model/expenses.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final CreateUseCase _useCase;

  CreateExpenseBloc({required CreateUseCase useCase}) : _useCase = useCase, super(CreateExpenseInitial()) {
    on<ExpensesIDChanged>(_onExpenseIDChanged);
    on<ExpensesTypeChanged>(_onExpenseTypeChanged);
    on<IssueDateChanged>(_onIssueDateChanged);
    on<CreateDateChanged>(_onCreateDateChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<CurrencyChanged>(_onCurrencyChanged);
    on<AmountChanged>(_onAmountChanged);
    on<RemarkChanged>(_onRemarkChanged);
    on<IsNewChanged>(_onIsNewChanged);
    on<IsUpdateChanged>(_onIsUpdateChanged);
    on<SaveEvent>(_onSaved);
    on<UpdateEvent>(_onUpdated);
  }

  void _onExpenseIDChanged(
      ExpensesIDChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            id: event.id
        )
    );
  }

  void _onExpenseTypeChanged(
      ExpensesTypeChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
      state.copyWith(
        statusType: event.expensesType
      )
    );
  }

  void _onIssueDateChanged(
      IssueDateChanged event,
      Emitter<CreateExpenseState> emit,
  ) {
    emit(
      state.copyWith(
        issueDate: event.issueDate
      )
    );
  }

  void _onCreateDateChanged(
      CreateDateChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            createDate: event.createDate
        )
    );
  }

  void _onCategoryChanged(
      CategoryChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            categoryImage: event.image,
            category: event.category
        )
    );
  }

  void _onCurrencyChanged(
      CurrencyChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            currencyCode: event.currency
        )
    );
  }

  void _onAmountChanged(
      AmountChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            amount: event.amount
        )
    );
  }

  void _onRemarkChanged(
      RemarkChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            remark: event.remark
        )
    );
  }

  void _onIsNewChanged(
      IsNewChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            isNew: event.isNew
        )
    );
  }

  void _onIsUpdateChanged(
      IsUpdateChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            isUpdate: event.isUpdate
        )
    );
  }

  Future<void> _onSaved(
      SaveEvent event,
      Emitter<CreateExpenseState> emit,
      ) async {

      var expenses = Expenses(
          statusType: state.statusType ?? "1",
          issueDate: DateFormat(DateUtil.YEAR_MONTH_DAY_TIME).format(state.issueDate ?? DateTime.now()),
          createDate: DateFormat(DateUtil.YEAR_MONTH_DAY_TIME).format(DateTime.now()),
          categoryImage: state.categoryImage,
          category: state.category,
          currencyCode: state.currencyCode ?? "USD",
          amount: state.amount == null ? "0.0" : state.amount.toString(),
          remark: state.remark
      );
      await _useCase.save(expenses);
  }

  Future<void> _onUpdated(
     UpdateEvent event,
     Emitter<CreateExpenseState> emit
  ) async {
    var expenses = Expenses(
        id: state.id,
        statusType: state.statusType ?? "1",
        issueDate: DateFormat(DateUtil.YEAR_MONTH_DAY_TIME).format(state.issueDate ?? DateTime.now()),
        createDate: DateFormat(DateUtil.YEAR_MONTH_DAY_TIME).format(state.createDate ?? DateTime.now()),
        categoryImage: state.categoryImage,
        category: state.category,
        currencyCode: state.currencyCode ?? "USD",
        amount: state.amount == null ? "0.0" : state.amount.toString(),
        remark: state.remark
    );
    await _useCase.update(expenses);
  }

}
