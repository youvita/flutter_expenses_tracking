import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/pages/create/create_form.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../database/models/expenses.dart';
import '../../database/repo/expenses_db.dart';
import '../../widgets/app_topbar.dart';
import '../../widgets/bottombar/bottom_navigation_bar.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<StatefulWidget> createState() => CreateForm();

}

class CreateForm extends State {
  Expenses? expenses;
  String editButton = 'Edit'.tr();
  String saveButton = 'Save'.tr();

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments as Expenses;
    final isNew = params.statusType == null;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppTopBarWidget(
            title: isNew ? 'Create'.tr() : 'View'.tr(),
            actionEndIcon: isNew ? saveButton : editButton,
            actionLeftIcon: 'assets/images/ic_close.svg',
            actionRightIcon: isNew ? '' : 'Delete'.tr(),
            onActionRight: () {
              if (expenses != null) {
                ExpensesDb().delete(expenses!);
                _navigationListRoute(context);
              }
            },
            onActionLeft: () {
              Navigator.pop(context);
            },
            onActionEnd: () {
              if(isNew) {
                if (expenses != null) {
                  ExpensesDb().insert(expenses!);
                  _navigationListRoute(context);
                }
              } else {
                if (editButton == 'Save'.tr()) {
                  ExpensesDb().update(expenses!);
                  _navigationListRoute(context);
                } else {
                  setState(() {
                    editButton = saveButton;
                    params.updateChanged = true;
                  });
                }
              }
            }),
        backgroundColor: MyColors.white,
        body: CreateFormWidget(expenses: params, isNew: isNew, onValueChanged: (Expenses value) {
          expenses = value;
        },)
    );
  }

}

/// call back route page
Future<void> _navigationListRoute(context) async {
  Navigator.of(context).pushAndRemoveUntil(_listRoute(), (r) { return false;} );
}

/// animation route page
Route _listRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const BottomNavigationBarWidget(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
  );
}