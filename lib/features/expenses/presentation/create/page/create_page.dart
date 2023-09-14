import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/create_form.dart';
import 'package:expenses_tracking/widgets/app_topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenses_tracking/di/injection_container.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const CreatePage());
  }

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments as Expenses;
    final isNew = params.statusType == null;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppTopBarWidget(title: isNew ? "Create" : "View", onActionRight: () {
        Navigator.pop(context);
      }),
      backgroundColor: MyColors.white,
      body: BlocProvider(
        create: (_) => sl<CreateExpenseBloc>(),
        child: CreateFormWidget(expenses: params, isNew: isNew),
      ),
    );
  }
}