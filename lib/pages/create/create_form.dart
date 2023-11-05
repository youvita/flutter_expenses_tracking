import 'dart:ffi';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/database/models/category_popular.dart';
import 'package:expenses_tracking/database/repo/expenses_db.dart';
import 'package:expenses_tracking/pages/create/status_switch.dart';
import 'package:expenses_tracking/pages/create/text_remark_input.dart';
import 'package:expenses_tracking/widgets/divider_widget.dart';
import 'package:expenses_tracking/widgets/text_amount_Input.dart';
import 'package:expenses_tracking/widgets/text_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../widgets/bottombar/bottom_navigation_bar.dart';
import '../../database/models/category.dart';
import '../../database/models/expenses.dart';
import '../category/category_page.dart';
import 'category_item.dart';

class CreateFormWidget extends StatefulWidget {
  const CreateFormWidget({super.key, required this.expenses, required this.isNew, required this.onValueChanged});

  final Expenses expenses;
  final ValueChanged<Expenses> onValueChanged;
  final bool isNew;

  @override
  State<StatefulWidget> createState() => CreateForm();

}

class CreateForm extends State<CreateFormWidget> {

  @override
  void initState() {
    super.initState();
    widget.expenses.updateChanged = widget.isNew ? true : false;
    widget.expenses.newChanged = widget.isNew;
    widget.expenses.statusTypeChanged = widget.expenses.statusType;
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
                    _StatusTypeWidget(widget.expenses, (Expenses value) {
                      widget.onValueChanged(value);
                    }),
                    const SizedBox(height: 30),
                    _IssueDateWidget(widget.expenses, (Expenses value) {
                      widget.onValueChanged(value);
                    }),
                    const DividerWidget(),
                    _CategoryWidget(widget.expenses, (Expenses value) {
                      widget.onValueChanged(value);
                    }),
                    const DividerWidget(),
                    _AmountInputWidget(widget.expenses, () {
                      setState(() {
                        widget.onValueChanged(widget.expenses);
                      });
                    }),
                    const DividerWidget(),
                    _RemarkInputWidget(widget.expenses),
                    _CategoriesWidget(widget.expenses, () {
                      setState(() {
                        widget.onValueChanged(widget.expenses);
                      });
                    })
                  ],
                ),
              )
          ),
          // _SaveButton(widget.expenses, (){
          //   setState(() {
          //
          //   });
          // })
        ]
    );
  }

}

class _StatusTypeWidget extends StatefulWidget {

  const _StatusTypeWidget(this.expenses, this.onValueChanged);

  final Expenses expenses;
  final ValueChanged<Expenses> onValueChanged;

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

            widget.onValueChanged(widget.expenses);
    });
  }

}

class _IssueDateWidget extends StatefulWidget {

  const _IssueDateWidget(this.expenses, this.onValueChanged);

  final Expenses expenses;
  final ValueChanged<Expenses> onValueChanged;

  @override
  State<StatefulWidget> createState() => _IssueDateSelected();
}

class _IssueDateSelected extends State<_IssueDateWidget> {
  DateTime newDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    newDateTime = Utils.dateTimeFormat(widget.expenses.issueDate);
    widget.onValueChanged(widget.expenses);
  }

  @override
  Widget build(BuildContext context) {

    return TextSelectWidget(
        enable: widget.expenses.isUpdate ?? true,
        label: 'Date'.tr(),
        padding: const EdgeInsets.only(left: 20, top: 22, right: 20, bottom: 22),
        horSpace: 15,
        value: DateFormat('dd MMMM yyyy').format(newDateTime),
        imagePath: "assets/images/ic_calendar.svg",
        onTap: (_) async {
          if (Platform.isIOS) {
            showCupertinoModalPopup(context: context, builder: (BuildContext context) => Container(
              height: 216,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      DateTime currentTime = DateTime.now();
                      newDateTime = DateTime(newDate.year, newDate.month, newDate.day, currentTime.hour, currentTime.minute, currentTime.second);
                      widget.expenses.issueDateChanged = newDateTime;
                      widget.onValueChanged(widget.expenses);
                    });
                  },
                ),
              ),
            ));
          } else {
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
              widget.onValueChanged(widget.expenses);
            }
          }
        }
    );
  }

}

class _CategoryWidget extends StatefulWidget {

  const _CategoryWidget(this.expenses, this.onValueChanged);

  final Expenses expenses;
  final ValueChanged<Expenses> onValueChanged;

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
      widget.onValueChanged(widget.expenses);
    });
  }

  @override
  void initState() {
    super.initState();

    widget.expenses.categoryImageChanged = Utils().getUnicodeCharacter('1F35C');
    widget.expenses.categoryChanged = 'Food'.tr();
  }

  @override
  Widget build(BuildContext context) {

    return TextSelectWidget(
        enable: widget.expenses.isUpdate ?? true,
        label: 'Category'.tr(),
        value: widget.expenses.category == null ? 'Select'.tr() : "${widget.expenses.categoryImage} ${widget.expenses.category}",
        imagePath: "assets/images/ic_arrow_next.svg",
        onTap: (bool value) {
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
  String? amountInput;
  String? currency;

  @override
  void initState() {
    super.initState();
    amountInput = widget.expenses.amount;

    if (widget.expenses.isNew == true) {
      currency = Setting.currency;
    } else {
      currency = widget.expenses.currencyCode;
    }
  }

  @override
  Widget build(BuildContext context) {

    return TextAmountInputWidget(
        enable: widget.expenses.isUpdate ?? true,
        placeholder: 'Input'.tr(),
        value: Utils.formatDecimal(widget.expenses.currencyCode, amountInput),
        defaultCurrency: currency == 'USD' ? '1' : '2',
        onValueChanged: (String value) {
          setState(() {
            amountInput = value;
            widget.expenses.amountChanged = value;
            widget.expenses.currencyCodeChanged = currency;
            widget.callBack();
          });
        },
        onCurrencyChanged: (String value) {
          // setState(() {
          //   widget.expenses.currencyCodeChanged = value;
          // });
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
        label: 'Remark'.tr(),
        placeholder: 'Please Input'.tr(),
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

  List<CategoryPopular> popular = List.empty(growable: true);

  loadCategoryPopular() async {
    var pop = await ExpensesDb().getPopular();

    // if (pop.isNotEmpty) {
      setState(() {
        popular = pop;
        popular.insert(0, CategoryPopular(Utils().getUnicodeCharacter('1F35C'), 'Food'.tr(), 0));
        popular.insert(1, CategoryPopular(Utils().getUnicodeCharacter('1F379'), 'Drink'.tr(), 0));
        popular.insert(2, CategoryPopular(Utils().getUnicodeCharacter('26FD'), 'Gasoline'.tr(),0));
      });
    // }
  }

  @override
  void initState() {
    super.initState();
    loadCategoryPopular();
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = widget.expenses.isUpdate ?? true;

    return Visibility(
        visible: popular.isNotEmpty,
        child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, top: 30, bottom: 17, right: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Popular Categories'.tr(), style: MyTextStyles.textStyleBold20),
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 120,
                            crossAxisCount: 4
                        ),
                        itemCount: popular.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryItemWidget(
                              enable: isUpdate,
                              image: popular.elementAt(index).image,
                              label: popular.elementAt(index).name,
                              onValueChanged: (String category) {
                                setState(() {
                                  final item = category.split(' ');
                                  widget.expenses.categoryImageChanged = item[0];
                                  widget.expenses.categoryChanged = item[1];
                                  widget.callBack();
                                });
                              }
                          );
                        }
                    ),
                  )
              )
            ]
        )
    );
  }

}

// class _SaveButton extends StatefulWidget {
//
//   const _SaveButton(this.expenses, this.callBack);
//   final Expenses expenses;
//   final Function callBack;
//   @override
//   State<StatefulWidget> createState() => _ButtonState();
// }
//
// class _ButtonState extends State<_SaveButton> {
//   String editButton = 'Edit'.tr();
//   String saveButton = 'Save'.tr();
//
//   @override
//   Widget build(BuildContext context) {
//     bool isNew = widget.expenses.isNew ?? true;
//
//     return SafeArea(
//         child: Container(
//             padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
//             child: ElevatedButton(
//               key: const Key('createForm_saveButton'),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: MyColors.blue,
//                   minimumSize: const Size.fromHeight(50),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6)
//                   )
//               ),
//               onPressed: ()  {
//                 if (isNew) {
//                   ExpensesDb().insert(widget.expenses);
//                   // _navigationListRoute(context);
//                 } else {
//                   if (editButton == 'Save'.tr()) {
//                     ExpensesDb().update(widget.expenses);
//                     // _navigationListRoute(context);
//                   } else {
//                     setState(() {
//                       editButton = saveButton;
//                       widget.expenses.updateChanged = true;
//                       widget.callBack();
//                     });
//                   }
//                 }
//               },
//               child: Text(isNew ? saveButton : editButton, style: MyTextStyles.textStyleMediumWhite15),
//             )
//         )
//     );
//   }
//
// }

/// call back route page
Future<Category> _navigationCategoryRoute(BuildContext context) async {
  final Category result = await Navigator.of(context).push(_categoryRoute());
  return result;
}

/// animation route page
Route _categoryRoute() {
  return CupertinoPageRoute(builder: (context) => const CategoryPage());
  // return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => const CategoryPage(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset.zero;
  //       const end = Offset.zero;
  //       const curve = Curves.ease;
  //
  //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     }
  // );
}



