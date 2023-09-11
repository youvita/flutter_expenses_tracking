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
  var isHeader = false;
  var lastTile = "";
  var isTile = false;

  @override
  Widget build(BuildContext context) {
    List<Expenses>? listItem = List.empty();

    setState(() {
      listItem = context.select((ListExpenseBloc bloc) => bloc.state.listExpenses);
    });

    return ListView.builder(
        itemCount: listItem?.length,
        itemBuilder: (context, index) {
          Expenses? item = listItem?.elementAt(index);
          DateTime dateTime = Utils.dateTimeFormat("${item?.createDate}");
          String header = Utils.dateFormatYear(dateTime);

          print(header);
          /// header condition check
          if (lastHeader != header) {
              isHeader = true;
              lastHeader = header;
          } else {
              isHeader = false;
          }

          String tile = Utils.dateFormatYearMonth(dateTime);
          print(tile);
          if (lastTile != tile) {
            isTile = true;
            lastTile = tile;
          } else {
            isTile = false;
          }

          return StickyHeader(
              header: isHeader ? Container(
                  padding: const EdgeInsets.only(left: 20, top: 7, right: 20, bottom: 7),
                  child: Text(header, style: MyTextStyles.textStyleMedium17)
              ) : const SizedBox(),
              content: ExpansionTile(
                title: Text("Header"),
                children: [
                  isTile ?
                  Column(
                    children: [
                      ListItem(item: item),
                      item == listItem?.last ? const SizedBox()
                          : Container(
                          padding: const EdgeInsets.only(left: 70),
                          child: const Divider(
                              height: 0,
                              thickness: 1
                          ))
                    ],
                  ):
                  Column(
                    children: [
                      ListItem(item: item),
                      item == listItem?.last ? const SizedBox()
                          : Container(
                          padding: const EdgeInsets.only(left: 70),
                          child: const Divider(
                              height: 0,
                              thickness: 1
                          ))
                    ],
                  )
                ],
              )
          );
        }
    );
  }

}