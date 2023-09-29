
import 'package:expenses_tracking/config/utils.dart';
import 'package:flutter/material.dart';

import '../../../../../constant/constant.dart';
import '../../database/models/expenses.dart';

class ListItem extends StatefulWidget {
  final Expenses? item;
  final ValueChanged<Expenses?> onItemSelected;

  const ListItem({Key? key, this.item, required this.onItemSelected}): super(key: key);

  @override
  State<StatefulWidget> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          widget.onItemSelected(widget.item);
      },
      child: Padding(padding: const EdgeInsets.only(left: 20, top: 13, bottom: 13, right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(widget.item?.categoryImage ?? "", style: const TextStyle(fontSize: 30)),
              const SizedBox(width: 13),
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.item?.category ?? "", style: MyTextStyles.textStyleMedium17),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Utils.dateFormat(Utils.dateTimeFormat("${widget.item?.issueDate}")), style: MyTextStyles.textStyleNormal15),
                      Text('${widget.item?.statusType == '1' ? '-' : '+'}${Utils.formatCurrency(widget.item?.currencyCode, widget.item?.amount)}', style: widget.item?.statusType == '1' ? MyTextStyles.textStyleMedium17Red : MyTextStyles.textStyleMedium17Green)
                    ],
                  )
                ])
              )
            ],
          ))
    );
  }

}