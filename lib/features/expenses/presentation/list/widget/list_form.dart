import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/bloc/list_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/widget/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ListFormWidget extends StatefulWidget {
  const ListFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListFormState();

}

class _ListFormState extends State<ListFormWidget> {
  var lastHeader = "";
  var lastChildHeader = "";

  @override
  Widget build(BuildContext context) {
    List<Expenses> listItem = List.empty();
    List<String> listHeader = List.empty(growable: true);
    List<String> listChildHeader = List.empty(growable: true);

    setState(() {
      listItem = context.select((ListExpenseBloc bloc) => bloc.state.listExpenses ?? List.empty());

      for (var i = 0; i < listItem.length; i++) {
        DateTime dateTime = Utils.dateTimeFormat("${listItem.elementAt(i).createDate}");
        String header = Utils.dateFormatYear(dateTime);
        String childHeader = Utils.dateFormatYearMonth(dateTime);
        if (lastHeader != header) {
          listHeader.add(header);
          lastHeader = header;
        }
      }
    });

    return ListView.builder(
        itemCount: listHeader.length,
        itemBuilder: (BuildContext context, int index) {
          return StickyHeader(
              header: ColoredBox(
                color: MyColors.greyBackground,
                child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 7, right: 20, bottom: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(listHeader.elementAt(index), style: MyTextStyles.textStyleMedium17)
                      ],
                    )
                ),
              ),
              content: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                      children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listItem.length,
                                itemBuilder: (context, indexChild) {
                                  Expenses? childItem = listItem.elementAt(indexChild);
                                  return listHeader.elementAt(index) == Utils.dateFormatYear(Utils.dateTimeFormat("${childItem.createDate}")) ?
                                  Column(
                                    children: [
                                      ListItem(item: childItem),
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
                      ]))

              // ExpansionTile(
              //   title: Text("Header"),
              //   children: [
              //     isTile ?
              //     Column(
              //       children: [
              //         ListItem(item: item),
              //         item == listItem?.last ? const SizedBox()
              //             : Container(
              //             padding: const EdgeInsets.only(left: 70),
              //             child: const Divider(
              //                 height: 0,
              //                 thickness: 1
              //             ))
              //       ],
              //     ):
              //     Column(
              //       children: [
              //         ListItem(item: item),
              //         item == listItem?.last ? const SizedBox()
              //             : Container(
              //             padding: const EdgeInsets.only(left: 70),
              //             child: const Divider(
              //                 height: 0,
              //                 thickness: 1
              //             ))
              //       ],
              //     )
              //   ],
              // )
          );
        }
    );
  }

}