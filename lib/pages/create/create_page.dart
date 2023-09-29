import 'package:expenses_tracking/pages/create/create_form.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../database/models/expenses.dart';
import '../../widgets/app_topbar.dart';

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
      body: CreateFormWidget(expenses: params, isNew: isNew)
    );
  }
}