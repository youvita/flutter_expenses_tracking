import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/bloc/list_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/widget/list_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenses_tracking/di/injection_container.dart';

import '../../../../../widgets/default_app_bar.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ListPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(title: 'Expense'),
      backgroundColor: MyColors.greyBackground,
      body: BlocProvider(
        create: (_) => sl<ListExpenseBloc>()..add(ListExpenseInitial() as ListExpenseEvent),
        child: const ListFormWidget(),
      ),
    );
  }
}