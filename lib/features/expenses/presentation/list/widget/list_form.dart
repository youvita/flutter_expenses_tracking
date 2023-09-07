

import 'package:expenses_tracking/config/utils.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/bloc/list_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/widget/list_item.dart';
import 'package:expenses_tracking/widgets/divider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFormWidget extends StatefulWidget {
  const ListFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListFormState();

}

class _ListFormState extends State<ListFormWidget> {
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
          return Column(
            children: [
              ListItem(item: item),
              index == (listItem!.length - 1) ? const SizedBox()
              : Container(
          padding: const EdgeInsets.only(left: 70),
          child: const Divider(
          height: 0,
          thickness: 1
          ))
            ],
          );
        }
    );
  }

}