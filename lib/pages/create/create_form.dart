import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/database/repo/expenses_db.dart';
import 'package:expenses_tracking/database/service/database_service.dart';
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

  @override
  Widget build(BuildContext context) {
    widget.expenses.updateChanged = widget.isNew ? true : false;
    widget.expenses.newChanged = widget.isNew;
    widget.expenses.statusTypeChanged = widget.expenses.statusType;
    // widget.expenses.expenseIDChanged = widget.expenses.id ?? -1;
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
                    _StatusTypeWidget(widget.expenses),
                    const SizedBox(height: 30),
                    _IssueDateWidget(widget.expenses),
                    const DividerWidget(),
                    _CategoryWidget(widget.expenses),
                    const DividerWidget(),
                    _AmountInputWidget(widget.expenses, () {
                      setState(() {

                      });
                    }),
                    const DividerWidget(),
                    _RemarkInputWidget(widget.expenses),
                    _CategoriesWidget(widget.expenses, () {
                      setState(() {

                      });
                    })
                  ],
                ),
              )
          ),
          _SaveButton(widget.expenses)
        ]
    );
  }

}

class _StatusTypeWidget extends StatefulWidget {

  const _StatusTypeWidget(this.expenses);

  final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _ExpenseTypeSelected();
}

class _ExpenseTypeSelected extends State<_StatusTypeWidget> {
  bool _enable = true;

  @override
  void initState() {
    super.initState();
    _enable = widget.expenses.statusType == '1' ? true : false;
  }

  @override
  Widget build(BuildContext context) {

    return StatusSwitch(
        enable: widget.expenses.isUpdate ?? true,
        value: _enable,
        onChanged: (bool val) {
            setState(() {
              _enable = val;
            });

            if (_enable) {
              widget.expenses.statusTypeChanged = '1';
            } else {
              widget.expenses.statusTypeChanged = '2';
            }
    });
  }

}

class _IssueDateWidget extends StatefulWidget {

  const _IssueDateWidget(this.expenses);

  final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _IssueDateSelected();
}

class _IssueDateSelected extends State<_IssueDateWidget> {
  DateTime newDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    newDateTime = Utils.dateTimeFormat(widget.expenses.issueDate);
  }

  @override
  Widget build(BuildContext context) {

    return TextSelectWidget(
        enable: widget.expenses.isUpdate ?? true,
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
                  widget.expenses.issueDateChanged = newDateTime;
                }
        }
    );
  }

}

class _CategoryWidget extends StatefulWidget {

  const _CategoryWidget(this.expenses);

  final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _CategoryInput();
}

class _CategoryInput extends State<_CategoryWidget> {
  String category = '';
  String categoryImage = '';

  callBack() async {
    Category category = await _navigationCategoryRoute(context);
    setState(() {
      widget.expenses.categoryImageChanged = category.image;
      widget.expenses.categoryChanged = category.name;
    });
  }

  @override
  Widget build(BuildContext context) {

    return TextSelectWidget(
        enable: widget.expenses.isUpdate ?? true,
        label: "Category",
        value: widget.expenses.category == null ? "Select" : "${widget.expenses.categoryImage} ${widget.expenses.category}",
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (bool value) {
          // widget.onSelected(value);
          callBack();
        });
  }

}

class _AmountInputWidget extends StatefulWidget {

  const _AmountInputWidget(this.expenses, this.callBack);

  final Function callBack;
  final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _AmountInput();

}

class _AmountInput extends State<_AmountInputWidget> {
  String amountInput = '';

  @override
  void initState() {
    super.initState();
    amountInput = widget.expenses.amount ?? '';
  }

  @override
  Widget build(BuildContext context) {

    return TextAmountInputWidget(
        enable: widget.expenses.isUpdate ?? true,
        placeholder: "Input",
        value: amountInput,
        onValueChanged: (String value) {
          setState(() {
            amountInput = value;
            widget.expenses.amountChanged = value;
            widget.callBack();
          });
        }, onCurrencyChanged: (String value) {
          setState(() {
            widget.expenses.currencyCodeChanged = value;
          });
        }
    );
  }

}

class _RemarkInputWidget extends StatefulWidget {

  const _RemarkInputWidget(this.expenses);

  final Expenses expenses;

  @override
  State<StatefulWidget> createState() => _RemarkInputState();
}

class _RemarkInputState extends State<_RemarkInputWidget> {
  String remark = "";

  @override
  void initState() {
    super.initState();
    remark = widget.expenses.remark ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = widget.expenses.amount;

    return TextRemarkInputWidget(
        enable: widget.expenses.isUpdate ?? true,
        isVisible: isVisible != null && isVisible != '',
        label: "Remark",
        placeholder: "Please Input",
        value: remark,
        onValueChanged: (String value) {
          setState(() {
            remark = value;
            widget.expenses.remarkChanged = value;
          });
        }
      );
  }

}

class _CategoriesWidget extends StatefulWidget {

  const _CategoriesWidget(this.expenses, this.callBack);

  final Expenses expenses;
  final Function callBack;

  @override
  State<StatefulWidget> createState() => _CategoryState();
}

class _CategoryState extends State<_CategoriesWidget> {

  @override
  Widget build(BuildContext context) {
    bool isUpdate = widget.expenses.isUpdate ?? true;
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
                  label: 'Salary',
                  onValueChanged: (String category) {
                    setState(() {
                      final item = category.split(' ');
                      widget.expenses.categoryImageChanged = item[0];
                      widget.expenses.categoryChanged = item[1];
                      widget.callBack();
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
                    widget.expenses.categoryImageChanged = item[0];
                    widget.expenses.categoryChanged = item[1];
                    widget.callBack();
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
                    widget.expenses.categoryImageChanged = item[0];
                    widget.expenses.categoryChanged = item[1];
                    widget.callBack();
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
                    widget.expenses.categoryImageChanged = item[0];
                    widget.expenses.categoryChanged = item[1];
                    widget.callBack();
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

  const _SaveButton(this.expenses);
  final Expenses expenses;
  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<_SaveButton> {
  String editButton = 'Edit';
  String saveButton = 'Save';

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.expenses.isNew ?? true;

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
          onPressed: ()  {
            if (isNew) {
              ExpensesDb().insert(widget.expenses);
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
Future<Category> _navigationCategoryRoute(BuildContext context) async {
  final Category result = await Navigator.of(context).push(_categoryRoute());
  return result;
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

