import 'dart:io';

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
  const CreateFormWidget({super.key, required this.expenses, required this.isNew});

  final Expenses expenses;
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
          _SaveButton(widget.expenses, (){
            setState(() {

            });
          })
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
            }
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
        placeholder: "Input",
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

  List<CategoryPopular> popular = List.empty(growable: true);

  loadCategoryPopular() async {
    var pop = await ExpensesDb().getPopular();

    if (pop.isNotEmpty) {
      setState(() {
        popular = pop;
        // for (int i = 0; i < pop.length; i++) {
        //   print(pop.elementAt(i).image);
        //   for (int j = i; j < popular.length; j++) {
        //     if (popular.elementAt(j).name == pop.elementAt(i).name) {
        //       popular.removeAt(j);
        //       popular.insert(j, CategoryPopular(pop
        //           .elementAt(i)
        //           .image, pop
        //           .elementAt(i)
        //           .name, pop
        //           .elementAt(i)
        //           .count));
        //     }
        //   }
        // }

        // for (int i = 0; i < popular.length; i++) {
        //   for (int j = i; j < pop.length; j++) {
        //     if (popular.elementAt(i).name == pop.elementAt(j).name) {
        //       popular.removeAt(i);
        //       popular.insert(i, CategoryPopular(pop
        //           .elementAt(j)
        //           .image, pop
        //           .elementAt(j)
        //           .name, pop
        //           .elementAt(j)
        //           .count));
        //     }
        //   }
        // }
        //
        // popular.sort((p1, p2) {
        //   return Comparable.compare(p2.count, p1.count);
        // });
        //
        // for (int i = 0; i < popular.length; i++) {
        //   print(popular.elementAt(i).count);
        // }
        // if (pop.length == 1) {
        //   popular.removeAt(0);
        //   popular.insert(0,
        //       (pop.elementAt(0).count > 1 ? isOverride(pop) ?
        //       CategoryPopular(pop
        //           .elementAt(0)
        //           .image, pop
        //           .elementAt(0)
        //           .name, pop
        //           .elementAt(0)
        //           .count
        //       ) : CategoryPopular(Utils().getUnicodeCharacter('1F4B2'), 'Salary', 0)
        //       : CategoryPopular(Utils().getUnicodeCharacter('1F4B2'), 'Salary', 0)
        //       )
        //   );
        // }
        //
        // if (pop.length == 2) {
        //   popular.removeAt(1);
        //   popular.insert(1, ((pop
        //       .elementAt(1)
        //       .count > 1 ? CategoryPopular(pop
        //       .elementAt(1)
        //       .image, pop
        //       .elementAt(1)
        //       .name, pop
        //       .elementAt(1)
        //       .count) : isOverride(pop) ? CategoryPopular(pop
        //       .elementAt(1)
        //       .image, pop
        //       .elementAt(1)
        //       .name, pop
        //       .elementAt(1)
        //       .count) : CategoryPopular(
        //       Utils().getUnicodeCharacter('1F4B0'), 'Bonus', 0))));
        // }
        //
        // if (pop.length == 3)
        //   {
        //     popular.removeAt(2);
        //     popular.insert(2, (pop
        //         .elementAt(2)
        //         .count > 1 ? CategoryPopular(pop
        //         .elementAt(2)
        //         .image, pop
        //         .elementAt(2)
        //         .name, pop
        //         .elementAt(2)
        //         .count) : isOverride(pop) ? CategoryPopular(pop
        //         .elementAt(2)
        //         .image, pop
        //         .elementAt(2)
        //         .name, pop
        //         .elementAt(2)
        //         .count) : CategoryPopular(
        //         Utils().getUnicodeCharacter('1F48A'), 'Health', 0)));
        //   }
        //
        // if (pop.length == 4) {
        //   popular.removeAt(3);
        //   popular.insert(3, (pop
        //       .elementAt(3)
        //       .count > 1 ? CategoryPopular(pop
        //       .elementAt(3)
        //       .image, pop
        //       .elementAt(3)
        //       .name, pop
        //       .elementAt(3)
        //       .count) : isOverride(pop) ? CategoryPopular(pop
        //       .elementAt(3)
        //       .image, pop
        //       .elementAt(3)
        //       .name, pop
        //       .elementAt(3)
        //       .count) : CategoryPopular(
        //       Utils().getUnicodeCharacter('1F68C'), 'Transport', 0)));
        // }
      });
    }
  }

  isOverride(List<CategoryPopular> list) {
    for (int i = 0; i < list.length; i++) {
      if (list.elementAt(i).name == 'Salary' || list.elementAt(i).name == 'Bonus' || list.elementAt(i).name == 'Health' || list.elementAt(i).name == 'Transport') {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // popular.add(CategoryPopular(Utils().getUnicodeCharacter('1F4B2'), 'Salary', 1));
    // popular.add(CategoryPopular(Utils().getUnicodeCharacter('1F4B0'), 'Bonus', 1));
    // popular.add(CategoryPopular(Utils().getUnicodeCharacter('1F48A'), 'Health', 1));
    // popular.add(CategoryPopular(Utils().getUnicodeCharacter('1F68C'), 'Transport', 1));
    loadCategoryPopular();
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = widget.expenses.isUpdate ?? true;

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 17, right: 20),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Popular Categories', style: MyTextStyles.textStyleBold20),
            )
        ),
        Visibility(
            visible: popular.isNotEmpty,
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                ),
                // child: ,
          //       child: Row(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             CategoryItemWidget(
          //                 enable: isUpdate,
          //                 image: popular.elementAt(0).image,
          //                 label: popular.elementAt(0).name,
          //                 onValueChanged: (String category) {
          //                   setState(() {
          //                     final item = category.split(' ');
          //                     widget.expenses.categoryImageChanged = item[0];
          //                     widget.expenses.categoryChanged = item[1];
          //                     widget.callBack();
          //                   });
          //                 }
          //             ),
          //             CategoryItemWidget(
          //               enable: isUpdate,
          //               image: popular.elementAt(1).image,
          //               label: popular.elementAt(1).name,
          //               onValueChanged: (String category) {
          //                 setState(() {
          //                   final item = category.split(' ');
          //                   widget.expenses.categoryImageChanged = item[0];
          //                   widget.expenses.categoryChanged = item[1];
          //                   widget.callBack();
          //                 });
          //               },
          //             ),
          //             CategoryItemWidget(
          //               enable: isUpdate,
          //               image: popular.elementAt(2).image,
          //               label: popular.elementAt(2).name,
          //               onValueChanged: (String category) {
          //                 setState(() {
          //                   final item = category.split(' ');
          //                   widget.expenses.categoryImageChanged = item[0];
          //                   widget.expenses.categoryChanged = item[1];
          //                   widget.callBack();
          //                 });
          //               },
          //             ),
          //             CategoryItemWidget(
          //               enable: isUpdate,
          //               image: popular.elementAt(3).image,
          //               label: popular.elementAt(3).name,
          //               onValueChanged: (String category) {
          //                 setState(() {
          //                   final item = category.split(' ');
          //                   widget.expenses.categoryImageChanged = item[0];
          //                   widget.expenses.categoryChanged = item[1];
          //                   widget.callBack();
          //                 });
          //               },
          //             )
          //   ],
          // ),
        )
        )
      ],
    );
  }

}

class _SaveButton extends StatefulWidget {

  const _SaveButton(this.expenses, this.callBack);
  final Expenses expenses;
  final Function callBack;
  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<_SaveButton> {
  String editButton = 'Edit';
  String saveButton = 'Save';

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.expenses.isNew ?? true;

    return SafeArea(
        child: Container(
            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            child: ElevatedButton(
              key: const Key('createForm_saveButton'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.blue,
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
                    ExpensesDb().update(widget.expenses);
                    _navigationListRoute(context);
                  } else {
                    setState(() {
                      editButton = saveButton;
                      widget.expenses.updateChanged = true;
                      widget.callBack();
                    });
                  }
                }
              },
              child: Text(isNew ? saveButton : editButton, style: MyTextStyles.textStyleMediumWhite15),
            )
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

