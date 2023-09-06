
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTopBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double elevation;
  final Function? onActionRight;

  const AppTopBarWidget(
      {Key? key, this.title = "", this.backgroundColor = MyColors.white, this.elevation = 0.0, this.onActionRight}
      ) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize;

  @override
  State<StatefulWidget> createState() => _AppTopBarState();

}

class _AppTopBarState extends State<AppTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(widget.title, style: MyTextStyles.textStyleBold20),
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      actions: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            widget.onActionRight!();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset("assets/images/ic_close.svg")
          ),
        )
      ],
    );
  }

}