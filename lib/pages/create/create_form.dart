import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/pages/create/global_variables.dart';
import 'package:expenses_tracking/pages/create/status_switch.dart';
import 'package:expenses_tracking/pages/create/text_remark_input.dart';
import 'package:expenses_tracking/widgets/divider_widget.dart';
import 'package:expenses_tracking/widgets/text_amount_Input.dart';
import 'package:expenses_tracking/widgets/text_select.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../widgets/bottombar/bottom_navigation_bar.dart';
import '../../database/models/category.dart';
import '../../database/models/expenses.dart';
import '../category/category_page.dart';
import 'category_item.dart';

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
    Expenses.updateChanged(widget.isNew ? true : false);
    Expenses.newChanged(widget.isNew);
    // context.read<CreateExpenseBloc>().add(IsNewChanged(widget.isNew));
    // context.read<CreateExpenseBloc>().add(IsUpdateChanged(widget.isNew ? true : false));
    // context.read<CreateExpenseBloc>().add(ExpensesIDChanged(widget.expenses.id ?? -1));
    // context.read<CreateExpenseBloc>().add(CreateDateChanged(Utils.dateTimeFormat(widget.expenses.createDate ?? '')));

    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _StatusTypeWidget(),
                    const SizedBox(height: 30),
                    _IssueDateWidget(),
                    const DividerWidget(),
                    _CategoryWidget(),
                    const DividerWidget(),
                    _AmountInputWidget(),
                    const DividerWidget(),
                    _RemarkInputWidget(),
                    _CategoriesWidget()
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

  // const _StatusTypeWidget(this.expenses);
  //
  // // final String? status;
  // // final bool? isUpdate;
  // final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _ExpenseTypeSelected();
}

class _ExpenseTypeSelected extends State<_StatusTypeWidget> {
  bool _enable = true;


  @override
  void initState() {
    super.initState();
    // context.read<CreateExpenseBloc>().add(ExpensesTypeChanged(widget.status));
    // Expenses.statusTypeChanged(Expenses.statusType);
    _enable = Expenses.statusType == '1' ? true : false;
  }

  @override
  Widget build(BuildContext context) {

    return StatusSwitch(
        enable: Expenses.isUpdate ?? true,
        value: _enable,
        onChanged: (bool val) {
            setState(() {
              _enable = val;
            });

            if (_enable) {
              Expenses.statusTypeChanged('1');
            } else {
              Expenses.statusTypeChanged('2');
            }
    });
  }

}

class _IssueDateWidget extends StatefulWidget {
  //
  // const _IssueDateWidget(this.expenses);
  // //
  // // final DateTime? dateTime;
  // final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _IssueDateSelected();
}

class _IssueDateSelected extends State<_IssueDateWidget> {
  DateTime newDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // context.read<CreateExpenseBloc>().add(IssueDateChanged(widget.dateTime));
    newDateTime = Utils.dateTimeFormat(Expenses.issueDate);
  }

  @override
  Widget build(BuildContext context) {
    // final issueDate = context.read<CreateExpenseBloc>();
    // bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return TextSelectWidget(
        enable: Expenses.isUpdate ?? true,
        label: "Date",
        padding: const EdgeInsets.only(left: 20, top: 22, right: 20, bottom: 22),
        horSpace: 15,
        value: DateFormat('dd MMMM yyyy').format(newDateTime),
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
                  Expenses.issueDateChanged(newDateTime);
                  // issueDate.add(IssueDateChanged(newDateTime));
                }
        }
    );
  }

}

class _CategoryWidget extends StatefulWidget {

  // final String? categoryName;
  // final String? categoryImage;

  // final Expenses expenses;
  //
  // const _CategoryWidget(this.expenses);

  @override
  State<StatefulWidget> createState() => _CategoryInput();
}

class _CategoryInput extends State<_CategoryWidget> {
  String category = '';
  String categoryImage = '';

  @override
  void initState() {
    super.initState();
    // context.read<CreateExpenseBloc>().add(CategoryChanged(widget.categoryImage, widget.categoryName));
    // category = GlobleVaraible.expenses.category ?? '';
    // categoryImage = GlobleVaraible.expenses.categoryImage ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);
    // String category = context.select((CreateExpenseBloc bloc) => bloc.state.category ?? '');
    // String categoryImage = context.select((CreateExpenseBloc bloc) => bloc.state.categoryImage ?? '');
    setState(() {
      category = GlobalVariables.category ?? '';
      categoryImage = GlobalVariables().categoryImage ?? '';
      print(category);
    });

    return TextSelectWidget(
        enable: Expenses.isUpdate ?? true,
        label: "Category",
        value: GlobalVariables.category == null ? "Select" : "${GlobalVariables().categoryImage} ${GlobalVariables.category}",
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (bool value) {
          // widget.onSelected(value);
          _navigationCategoryRoute(context);
        });
  }

}

class _AmountInputWidget extends StatefulWidget {
  //
  // const _AmountInputWidget(this.expenses);
  // //
  // // final String? amount;
  // // final String? currency;
  //
  // final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _AmountInput();

}

class _AmountInput extends State<_AmountInputWidget> {
  String amountInput = '';

  @override
  void initState() {
    super.initState();
    amountInput = Expenses.amount ?? '0';
    // context.read<CreateExpenseBloc>().add(CurrencyChanged(widget.currency));
    // context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amountInput.isEmpty ? "0.0" : amountInput)));
  }

  @override
  Widget build(BuildContext context) {
    // bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return TextAmountInputWidget(
        enable: Expenses.isUpdate ?? true,
        placeholder: "Input",
        value: amountInput,
        onValueChanged: (String value) {
          setState(() {
            amountInput = value;
            Expenses.amountChanged(value);
          });
          // context.read<CreateExpenseBloc>().add(CurrencyChanged(value.currencyCode ?? "USD"));
          // context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amountInput.isEmpty ? "0.0" : amountInput)));
        }, onCurrencyChanged: (String value) {
          setState(() {
            Expenses.currencyCodeChanged(value);
          });
        }
    );
  }

}

class _RemarkInputWidget extends StatefulWidget {

  // const _RemarkInputWidget(this.expenses);
  // //
  // // final String? remark;
  // final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _RemarkInputState();
}

class _RemarkInputState extends State<_RemarkInputWidget> {
  String remark = "";

  @override
  void initState() {
    super.initState();
    // context.read<CreateExpenseBloc>().add(RemarkChanged(widget.remark ?? ''));
    remark = Expenses.remark ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = Expenses.amount;
    // bool isUpdate = context.select((CreateExpenseBloc bloc) => bloc.state.isUpdate ?? true);

    return TextRemarkInputWidget(
        enable: Expenses.isUpdate ?? true,
        isVisible: isVisible != null && isVisible != '0.0',
        label: "Remark",
        placeholder: "Please Input",
        value: remark,
        onValueChanged: (String value) {
          setState(() {
            remark = value;
            Expenses.remarkChanged(value);
          });
          // context.read<CreateExpenseBloc>().add(RemarkChanged(remark));
        }
      );
  }

}

class _CategoriesWidget extends StatefulWidget {
  // final bool isVisibleCategories;
  // const _CategoriesWidget(this.expenses);
  // final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _CategoryState();
}

class _CategoryState extends State<_CategoriesWidget> {

  @override
  Widget build(BuildContext context) {
    bool isUpdate = Expenses.isUpdate ?? true;
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
                  onValueChanged: (String category) {
                    setState(() {
                      final item = category.split(' ');
                      Expenses.categoryImageChanged(item[0]);
                      // Expenses.categoryChanged(item[1]);
                      GlobalVariables.category = item[1];
                      // Expenses.categoryImageChanged(item[0]);
                      // Expenses.categoryChanged(item[1]);
                      // context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                    });
                  }
              ),
              CategoryItemWidget(
                enable: isUpdate,
                image: Utils().getUnicodeCharacter("1F4B0"),
                label: "Bonus",
                onValueChanged: (String category) {
                  setState(() {
                    final item = category.split(' ');
                    Expenses.categoryImageChanged(item[0]);
                    Expenses.categoryChanged(item[1]);
                    // context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                  });
                },
              ),
              CategoryItemWidget(
                enable: isUpdate,
                image: Utils().getUnicodeCharacter("1F48A"),
                label: "Health",
                onValueChanged: (String category) {
                  setState(() {
                    final item = category.split(' ');
                    Expenses.categoryImageChanged(item[0]);
                    Expenses.categoryChanged(item[1]);
                    // context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                  });
                },
              ),
              CategoryItemWidget(
                enable: isUpdate,
                image: Utils().getUnicodeCharacter("1F68C"),
                label: "Transport",
                onValueChanged: (String category) {
                  setState(() {
                    final item = category.split(' ');
                    Expenses.categoryImageChanged(item[0]);
                    Expenses.categoryChanged(item[1]);
                    // context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                  });
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

  // const _SaveButton(this.expenses);
  // final Expenses expenses;
  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<_SaveButton> {
  String editButton = 'Edit';
  String saveButton = 'Save';

  @override
  Widget build(BuildContext context) {
    bool isNew = Expenses.isNew ?? true;
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
              // context.read<CreateExpenseBloc>().add(const SaveEvent());
              _navigationListRoute(context);
            } else {
              if (editButton == 'Save') {
                  // context.read<CreateExpenseBloc>().add(const UpdateEvent());
                  _navigationListRoute(context);
              } else {
                setState(() {
                  editButton = saveButton;
                  // context.read<CreateExpenseBloc>().add(const IsUpdateChanged(true));
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
  // context.read<CreateExpenseBloc>().add(CategoryChanged(result.image, result.name));
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

