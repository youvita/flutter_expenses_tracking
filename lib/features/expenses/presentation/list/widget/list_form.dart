import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/bloc/list_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/widget/list_item.dart';
import 'package:expenses_tracking/widgets/toggle_swich.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../create/page/create_page.dart';

class ListFormWidget extends StatefulWidget {
  const ListFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListFormState();

}

class _ListFormState extends State<ListFormWidget> {
  var lastHeaderYear = "";
  var lastHeaderMonth = "";
  var totalAmountYear = 0.0;
  var totalAmountMonth = 0.0;
  int toggleIndex = 0;

  List<Expenses> listItem = List.empty();
  List<String> listHeaderYear = List.empty(growable: true);
  List<DateTime> listHeaderMonth = List.empty(growable: true);
  List<double> listTotalEachYear = List.empty(growable: true);
  List<double> listTotalEachMonth = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    listItem = context.select((ListExpenseBloc bloc) => bloc.state.listExpenses ?? List.empty());

    setState(() {
      /// loop to filter header each year
      for (var i = 0; i < listItem.length; i++) {
        DateTime dateTime = Utils.dateTimeFormat("${listItem.elementAt(i).createDate}");
        String header = Utils.dateFormatYear(dateTime);
        String headerMonth = Utils.dateFormatYearMonth(dateTime);
        if (lastHeaderYear != header) {
          listHeaderYear.add(header);
          lastHeaderYear = header;
        }

        if (lastHeaderMonth != headerMonth) {
          listHeaderMonth.add(dateTime);
          lastHeaderMonth = headerMonth;
        }
      }

      /// loop to sum total amount each year
      for (var i = 0; i < listHeaderYear.length; i++) {
        for(var j = i; j < listItem.length; j++) {
          if (listHeaderYear.elementAt(i) == Utils.dateFormatYear(Utils.dateTimeFormat("${listItem.elementAt(j).createDate}"))) {
            totalAmountYear = totalAmountYear + double.parse(listItem.elementAt(j).amount ?? "");
          }
        }
        listTotalEachYear.add(totalAmountYear);
        totalAmountYear = 0.0;
      }

      /// loop to sum total amount each month
      for (var i = 0; i < listHeaderMonth.length; i++) {
        for (var j = i; j < listItem.length; j++) {
          if (Utils.dateFormatYearMonth(listHeaderMonth.elementAt(i)) == Utils.dateFormatYearMonth(Utils.dateTimeFormat("${listItem.elementAt(j).createDate}"))) {
            totalAmountMonth = totalAmountMonth + double.parse(listItem.elementAt(j).amount ?? "");
          }
        }
        listTotalEachMonth.add(totalAmountMonth);
        totalAmountMonth = 0.0;
      }
    });

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: ExpenseToggle(
                defaultIndex: toggleIndex,
                onToggle: (int index) {
                  if (toggleIndex != index) {
                    setState(() {
                      listHeaderYear.clear();
                      listItem.clear();
                      listTotalEachYear.clear();
                      listTotalEachMonth.clear();
                      listHeaderMonth.clear();
                      lastHeaderMonth = "";
                      lastHeaderYear = "";
                      totalAmountYear = 0.0;
                      totalAmountMonth = 0.0;
                      toggleIndex = index;
                      context.read<ListExpenseBloc>().add(
                          ListExpenseLoad(index == 0 ? '' : index.toString()));
                    });
                  }
                },
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: listHeaderYear.length,
                itemBuilder: (BuildContext context, int yearIndex) {
                  return StickyHeader(
                      header: ColoredBox(
                          color: MyColors.greyBackground,
                          child: Container(
                              padding: const EdgeInsets.only(left: 20, top: 7, right: 20, bottom: 7),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                      Text(listHeaderYear.elementAt(yearIndex), style: MyTextStyles.textStyleBold17),
                                      Text(listTotalEachYear.elementAt(yearIndex).toString(), style: MyTextStyles.textStyleMedium17Red),
                                  ],
                              )
                          ),
                      ),
                      content: Expanded(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listHeaderMonth.length,
                            itemBuilder: (BuildContext context, int monthIndex) {
                              return listHeaderYear.elementAt(yearIndex) == Utils.dateFormatYear(listHeaderMonth.elementAt(monthIndex)) ?
                              Column(
                                children: [
                                  ExpansionTile(
                                      leading: IntrinsicWidth(
                                        stepWidth: 350,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(Utils.dateFormatMonthYear(listHeaderMonth.elementAt(monthIndex)), style: MyTextStyles.textStyleMedium17),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(listTotalEachMonth.elementAt(monthIndex).toString(), style: MyTextStyles.textStyleMedium17Red),
                                                SvgPicture.asset('assets/images/ic_arrow_drop_down.svg')
                                              ],
                                            )
                                          ],
                                        )
                                      ),
                                      backgroundColor: MyColors.white,
                                      collapsedBackgroundColor: MyColors.white,
                                      trailing: const SizedBox(),
                                      title: const Text(''),
                                      children: [
                                        SingleChildScrollView(
                                            physics: const ScrollPhysics(),
                                            child: ColoredBox(
                                                color: MyColors.white,
                                                child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: listItem.length,
                                                    itemBuilder: (context, itemIndex) {
                                                      Expenses? childItem = listItem.elementAt(itemIndex);
                                                      return Utils.dateFormatYearMonth(listHeaderMonth.elementAt(monthIndex)) == Utils.dateFormatYearMonth(Utils.dateTimeFormat("${childItem.createDate}")) ?
                                                      Column(
                                                        children: [
                                                          ListItem(
                                                            item: childItem,
                                                            onItemSelected: (Expenses? value) {
                                                              _navigationRoute(context, value);
                                                            },
                                                          ),
                                                          childItem == listItem.last && Utils.dateFormatYearMonth(Utils.dateTimeFormat("${childItem.createDate}")) == Utils.dateFormatYearMonth(listHeaderMonth.last)? const SizedBox()
                                                              : Container(
                                                              padding: const EdgeInsets.only(left: 70),
                                                              child: const Divider(
                                                                  height: 0,
                                                                  thickness: 1
                                                              ))
                                                        ],
                                                      ) : const SizedBox();
                                                    }
                                                )
                                            )
                                        )
                                      ]),
                                  const SizedBox(height: 5)
                                ],
                              )
                                  : const SizedBox();
                            }),
                      )
                  );
                }
            ))
        ],
    );
  }
}

/// call back route page
Future<void> _navigationRoute(BuildContext context, Expenses? param) async {
  Navigator.of(context).push(_createRoute(param));
}

/// animation route page
Route _createRoute(Expenses? param) {
  return PageRouteBuilder(
      settings: RouteSettings(arguments: param),
      pageBuilder: (context, animation, secondaryAnimation) => const CreatePage(),
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