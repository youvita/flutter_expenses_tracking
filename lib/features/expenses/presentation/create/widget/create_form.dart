import 'package:expenses_tracking/config/date_util.dart';
import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/data/model/category.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/page/category_page.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/category_item.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/status_switch.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/text_remark_input.dart';
import 'package:expenses_tracking/widgets/divider_widget.dart';
import 'package:expenses_tracking/widgets/text_amount_Input.dart';
import 'package:expenses_tracking/widgets/text_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../widgets/bottombar/bottom_navigation_bar.dart';

class CreateFormWidget extends StatefulWidget {
  const CreateFormWidget({super.key, required this.expenses, required this.isNew});

  final Expenses expenses;
  final bool isNew;

  @override
  State<StatefulWidget> createState() => CreateForm();

}

class CreateForm extends State<CreateFormWidget> {
  bool isVisibleCategories = false;
  callBack(isSelected) {
    setState(() {
      isVisibleCategories = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<CreateExpenseBloc>().add(IsNewChanged(widget.isNew));
    context.read<CreateExpenseBloc>().add(IsUpdateChanged(widget.isNew ? true : false));
    context.read<CreateExpenseBloc>().add(ExpensesIDChanged(widget.expenses.id ?? -1));
    context.read<CreateExpenseBloc>().add(CreateDateChanged(Utils.dateTimeFormat(widget.expenses.createDate ?? '')));

    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _StatusTypeWidget(widget.expenses.statusType ?? '1'),
                    const SizedBox(height: 30),
                    _IssueDateWidget(Utils.dateTimeFormat(widget.expenses.issueDate ?? '')),
                    const DividerWidget(),
                    _CategoryWidget(widget.expenses.categoryImage ?? '', widget.expenses.category ?? ''),
                    const DividerWidget(),
                    _AmountInputWidget(widget.expenses.amount ?? '', widget.expenses.currencyCode ?? 'USD'),
                    const DividerWidget(),
                    _RemarkInputWidget(widget.expenses.remark ?? ''),
                    const _CategoriesWidget(isVisibleCategories: true)
                  ],
                ),
              )
          ),
          _SaveButton()
        ]
    );
  }

}

class _StatusTypeWidget extends StatefulWidget {

  const _StatusTypeWidget(this.status);

  final String status;

  @override
  State<StatefulWidget> createState() => _ExpenseTypeSelected();
}

class _ExpenseTypeSelected extends State<_StatusTypeWidget> {
  bool _enable = true;

  @override
  void initState() {
    super.initState();
    context.read<CreateExpenseBloc>().add(ExpensesTypeChanged(widget.status));
    _enable = widget.status == '1' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return StatusSwitch(
        enable: isUpdate,
        value: _enable,
        onChanged: (bool val) {
            setState(() {
              _enable = val;
            });

            if (_enable) {
              context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('1'));
            } else {
              context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('2'));
            }
    });
  }

}

class _IssueDateWidget extends StatefulWidget {

  const _IssueDateWidget(this.dateTime);

  final DateTime dateTime;

  @override
  State<StatefulWidget> createState() => _IssueDateSelected();
}

class _IssueDateSelected extends State<_IssueDateWidget> {
  DateTime newDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<CreateExpenseBloc>().add(IssueDateChanged(widget.dateTime));
    newDateTime = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    final issueDate = context.read<CreateExpenseBloc>();
    bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return TextSelectWidget(
        enable: isUpdate,
        label: "Date",
        padding: const EdgeInsets.only(left: 20, top: 22, right: 20, bottom: 22),
        horSpace: 15,
        value: DateFormat(DateUtil.DAY_MONTH_YEAR).format(newDateTime),
        imagePath: "assets/images/ic_calendar.svg",
        onTap: (_) async {
            DateTime? selectedDateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2100));

                if (selectedDateTime != null) {
                  DateTime currentTime = DateTime.now();
                  setState(() {
                    newDateTime = DateTime(selectedDateTime.year, selectedDateTime.month, selectedDateTime.day, currentTime.hour, currentTime.minute, currentTime.second);
                  });
                  issueDate.add(IssueDateChanged(newDateTime));
                }
        }
    );
  }

}

class _CategoryWidget extends StatefulWidget {

  final String categoryName;
  final String categoryImage;

  const _CategoryWidget(this.categoryImage, this.categoryName);

  @override
  State<StatefulWidget> createState() => _CategoryInput();
}

class _CategoryInput extends State<_CategoryWidget> {
  String category = '';
  String categoryImage = '';

  @override
  void initState() {
    super.initState();
    context.read<CreateExpenseBloc>().add(CategoryChanged(widget.categoryImage, widget.categoryName));
    category = widget.categoryName;
    categoryImage = widget.categoryImage;
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);
    String category = context.select((CreateExpenseBloc bloc) => bloc.state.category ?? '');
    String categoryImage = context.select((CreateExpenseBloc bloc) => bloc.state.categoryImage ?? '');

    return TextSelectWidget(
        enable: isUpdate,
        label: "Category",
        value: category.isEmpty ? "Select" : "$categoryImage $category",
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (bool value) {
          // widget.onSelected(value);
          _navigationCategoryRoute(context);
        });
  }

}

class _AmountInputWidget extends StatefulWidget {

  const _AmountInputWidget(this.amount, this.currency);

  final String amount;
  final String currency;

  @override
  State<StatefulWidget> createState() => _AmountInput();

}

class _AmountInput extends State<_AmountInputWidget> {
  String amountInput = '';

  @override
  void initState() {
    super.initState();
    amountInput = widget.amount;
    context.read<CreateExpenseBloc>().add(CurrencyChanged(widget.currency));
    context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amountInput.isEmpty ? "0.0" : amountInput)));
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return TextAmountInputWidget(
        enable: isUpdate,
        placeholder: "Input",
        value: amountInput,
        onValueChanged: (Expenses value) {
          setState(() {
            amountInput = value.amount!;
          });
          context.read<CreateExpenseBloc>().add(CurrencyChanged(value.currencyCode ?? "USD"));
          context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amountInput.isEmpty ? "0.0" : amountInput)));
        });
  }

}

class _RemarkInputWidget extends StatefulWidget {

  const _RemarkInputWidget(this.remark);

  final String remark;

  @override
  State<StatefulWidget> createState() => _RemarkInputState();
}

class _RemarkInputState extends State<_RemarkInputWidget> {
  String remark = "";

  @override
  void initState() {
    super.initState();
    context.read<CreateExpenseBloc>().add(RemarkChanged(widget.remark ?? ''));
    remark = widget.remark;
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = context.select((CreateExpenseBloc bloc) => bloc.state.amount);
    bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return TextRemarkInputWidget(
        enable: isUpdate,
        isVisible: isVisible != null && isVisible != 0.0,
        label: "Remark",
        placeholder: "Please Input",
        value: remark,
        onValueChanged: (String value) {
          setState(() {
            remark = value;
          });
          context.read<CreateExpenseBloc>().add(RemarkChanged(remark));
        }
      );
  }

}

class _CategoriesWidget extends StatefulWidget {
  final bool isVisibleCategories;
  const _CategoriesWidget({Key? key, required this.isVisibleCategories}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryState();
}

class _CategoryState extends State<_CategoriesWidget> {

  @override
  Widget build(BuildContext context) {
    bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 17, right: 20),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Popular Categories", style: MyTextStyles.textStyleBold20),
            )
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryItemWidget(
                  enable: isUpdate,
                  image: Utils().getUnicodeCharacter("1F4B2"),
                  label: "Salary",
                  onValueChanged: (Expenses category) {
                    setState(() {
                      context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                    });
                  }
              ),
              CategoryItemWidget(
                enable: isUpdate,
                image: Utils().getUnicodeCharacter("1F4B0"),
                label: "Bonus",
                onValueChanged: (Expenses category) {
                  setState(() {
                    context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                  });
                },
              ),
              CategoryItemWidget(
                enable: isUpdate,
                image: Utils().getUnicodeCharacter("1F48A"),
                label: "Health",
                onValueChanged: (Expenses category) {
                  setState(() {
                    context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                  });
                },
              ),
              CategoryItemWidget(
                enable: isUpdate,
                image: Utils().getUnicodeCharacter("1F68C"),
                label: "Transport",
                onValueChanged: (Expenses category) {
                  setState(() {
                    context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                  });
                  // _navigationRoute(context);
                },
              )
            ],
          ),
        )
      ],
    );
  }

}

class _SaveButton extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<_SaveButton> {
  String editButton = 'Edit';
  String saveButton = 'Save';

  @override
  Widget build(BuildContext context) {
    bool isNew = context.select((CreateExpenseBloc bloc) => bloc.state.isNew ?? true);
    return Container(
        padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: ElevatedButton(
          key: const Key('createForm_saveButton'),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
              )
          ),
          onPressed: () {
            if (isNew) {
              context.read<CreateExpenseBloc>().add(const SaveEvent());
              _navigationListRoute(context);
            } else {
              if (editButton == 'Save') {
                  context.read<CreateExpenseBloc>().add(const UpdateEvent());
                  _navigationListRoute(context);
              } else {
                setState(() {
                  editButton = saveButton;
                  context.read<CreateExpenseBloc>().add(const IsUpdateChanged(true));
                });
              }
            }
          },
          child: Text(isNew ? saveButton : editButton, style: MyTextStyles.textStyleMediumWhite15),
        )
    );
  }

}

/// call back route page
Future<void> _navigationCategoryRoute(BuildContext context) async {
  final Category result = await Navigator.of(context).push(_categoryRoute());
  context.read<CreateExpenseBloc>().add(CategoryChanged(result.image, result.name));
}

/// call back route page
Future<void> _navigationListRoute(context) async {
  Navigator.of(context).pushAndRemoveUntil(_listRoute(), (r) { return false;} );
}

/// animation route page
Route _categoryRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const CategoryPage(),
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

