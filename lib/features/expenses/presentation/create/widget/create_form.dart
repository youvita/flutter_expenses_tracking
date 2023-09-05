import 'package:expenses_tracking/config/date_util.dart';
import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constand/constand.dart';
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
import 'package:path/path.dart';

class CreateFormWidget extends StatefulWidget {
  const CreateFormWidget({super.key});

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
                    _CategoryWidget(onSelected: callBack),
                    const DividerWidget(),
                    _AmountInputWidget(),
                    const DividerWidget(),
                    _RemarkInputWidget(),
                    _CategoriesWidget(isVisibleCategories: isVisibleCategories)
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
  @override
  State<StatefulWidget> createState() => _ExpenseTypeSelected();
}

class _ExpenseTypeSelected extends State {
  bool _enable = true;
  @override
  Widget build(BuildContext context) {

    return StatusSwitch(value: _enable, onChanged: (bool val) {
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
  @override
  State<StatefulWidget> createState() => _IssueDateSelected();
}

class _IssueDateSelected extends State {
  DateTime newDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final issueDate = context.read<CreateExpenseBloc>();
    return TextSelectWidget(
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
  final Function onSelected;

  const _CategoryWidget({Key? key, required this.onSelected}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryInput();
}

class _CategoryInput extends State<_CategoryWidget> {

  @override
  Widget build(BuildContext context) {
    String? category = context.select((CreateExpenseBloc bloc) => bloc.state.category);
    String? categoryImage = context.select((CreateExpenseBloc bloc) => bloc.state.categoryImage);

    return TextSelectWidget(
        label: "Category",
        value: category == null ? "Select" : "$categoryImage $category",
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (bool value) {
          widget.onSelected(value);
        });
  }

}

class _AmountInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AmountInput();
}

class _AmountInput extends State {
  String amount = "";
  @override
  Widget build(BuildContext context) {
    return TextAmountInputWidget(
        placeholder: "Input",
        value: amount,
        onValueChanged: (Expenses value) {
          setState(() {
            amount = value.amount!;
          });
          context.read<CreateExpenseBloc>().add(CurrencyChanged(value.currencyCode ?? "USD"));
          context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amount.isEmpty ? "0.0" : amount)));
        });
  }

}

class _RemarkInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RemarkInputState();
}

class _RemarkInputState extends State {
  String remark = "";
  @override
  Widget build(BuildContext context) {
    final isVisible = context.select((CreateExpenseBloc bloc) => bloc.state.amount);

    return TextRemarkInputWidget(
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

class _CategoryState extends State<_CategoriesWidget> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
  }

  void _runExpandCheck() {
    if(widget.isVisibleCategories) {
      expandController.forward();
    }
    else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(_CategoriesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20, top: 40, bottom: 17, right: 20),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Categories", style: MyTextStyles.textStyleBold20),
                )
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryItemWidget(
                      image: Utils().getUnicodeCharacter("1F4B2"),
                      label: "Salary",
                      onValueChanged: (Expenses category) {
                        setState(() {
                          context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                        });
                      }
                  ),
                  CategoryItemWidget(
                    image: Utils().getUnicodeCharacter("1F4B0"),
                    label: "Bonus",
                    onValueChanged: (Expenses category) {
                      setState(() {
                        context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                      });
                    },
                  ),
                  CategoryItemWidget(
                    image: Utils().getUnicodeCharacter("1F48A"),
                    label: "Health",
                    onValueChanged: (Expenses category) {
                      setState(() {
                        context.read<CreateExpenseBloc>().add(CategoryChanged(category.categoryImage ?? "", category.category ?? ""));
                      });
                    },
                  ),
                  CategoryItemWidget(
                    image: "",
                    label: "Other",
                    onValueChanged: (Expenses category) {
                      _navigationRoute(context);
                    },
                  )
                ],
              ),
            )
          ],
        )
    );
  }

}

class _SaveButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
          context.read<CreateExpenseBloc>().add(const SaveEvent());
        },
        child: const Text('Save', style: MyTextStyles.textStyleMediumWhite15),
      )
    );
  }
}

/// call back route page
Future<void> _navigationRoute(BuildContext context) async {
  final Category result = await Navigator.of(context).push(_createRoute());
  context.read<CreateExpenseBloc>().add(CategoryChanged(result.image, result.name));
}

/// animation route page
Route _createRoute() {
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

