import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/bloc/list_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/widget/list_item.dart';
import 'package:expenses_tracking/widgets/toggle_swich.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../create/page/create_page.dart';

class ListFormWidget extends StatefulWidget {
  const ListFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListFormState();

}

class _ListFormState extends State<ListFormWidget> {
  var lastHeader = "";
  var totalAmount = 0.0;
  int toggleIndex = 0;

  List<Expenses> listItem = List.empty();
  List<String> listHeader = List.empty(growable: true);
  List<double> listTotal = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    listItem = context.select((ListExpenseBloc bloc) => bloc.state.listExpenses ?? List.empty());

    setState(() {
      /// loop to filter header each year
      for (var i = 0; i < listItem.length; i++) {
        DateTime dateTime = Utils.dateTimeFormat("${listItem.elementAt(i).createDate}");
        String header = Utils.dateFormatYear(dateTime);
        if (lastHeader != header) {
          listHeader.add(header);
          lastHeader = header;
        }
      }

      /// loop to sum total amount each year
      for (var i = 0; i < listHeader.length; i++) {
        for(var j = i; j < listItem.length; j++) {
          if (listHeader.elementAt(i) == Utils.dateFormatYear(Utils.dateTimeFormat("${listItem.elementAt(j).createDate}"))) {
            totalAmount = totalAmount + double.parse(listItem.elementAt(j).amount ?? "");
          }
        }
        listTotal.add(totalAmount);
        totalAmount = 0.0;
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
                      listHeader.clear();
                      listItem.clear();
                      listTotal.clear();
                      lastHeader = "";
                      totalAmount = 0.0;
                      toggleIndex = index;
                      context.read<ListExpenseBloc>().add(
                          ListExpenseLoad(index == 0 ? '' : index.toString()));
                    });
                  }
                },
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: listHeader.length,
                itemBuilder: (BuildContext context, int index) {
                  return StickyHeader(
                      header: ColoredBox(
                        color: MyColors.greyBackground,
                        child: Container(
                            padding: const EdgeInsets.only(left: 20, top: 7, right: 20, bottom: 7),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(listHeader.elementAt(index), style: MyTextStyles.textStyleMedium17),
                                Text(listTotal.elementAt(index).toString(), style: MyTextStyles.textStyleMedium17Red),
                              ],
                            )
                        ),
                      ),
                      content: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: ColoredBox(
                              color: MyColors.white,
                              child:
                              ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listItem.length,
                                    itemBuilder: (context, indexChild) {
                                      Expenses? childItem = listItem.elementAt(indexChild);
                                      return listHeader.elementAt(index) == Utils.dateFormatYear(Utils.dateTimeFormat("${childItem.createDate}")) ?
                                      Column(
                                        children: [
                                          ListItem(
                                              item: childItem,
                                              onItemSelected: (Expenses? value) {
                                                  print(value);
                                                 _navigationRoute(context, value);
                                              },
                                          ),
                                          childItem == listItem.last ? const SizedBox()
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