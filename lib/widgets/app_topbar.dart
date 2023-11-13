
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTopBarWidget extends StatefulWidget implements ObstructingPreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double elevation;
  final String actionLeftIcon;
  final String actionEndIcon;
  final String actionRightIcon;
  final Function? onActionLeft;
  final Function? onActionEnd;
  final Function? onActionRight;

  const AppTopBarWidget(
      {Key? key,
        this.title = "",
        this.backgroundColor = MyColors.white,
        this.elevation = 0.0,
        this.actionLeftIcon = "assets/images/ic_arrow_back.svg",
        this.actionEndIcon = "",
        this.actionRightIcon = "",
        this.onActionLeft,
        this.onActionEnd,
        this.onActionRight
      }
      ) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 55);

  @override
  State<AppTopBarWidget> createState() => _AppTopBarState();

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }

}

class _AppTopBarState extends State<AppTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: CupertinoNavigationBar(
        // centerTitle: true,
          middle: Text(widget.title, style: MyTextStyles.textStyleBold20),
          backgroundColor: widget.backgroundColor, border: Border.all(color: Colors.transparent),
          // elevation: widget.elevation,
          leading: Visibility(
              visible: widget.onActionLeft != null,
              child: CupertinoButton(
                // borderRadius: BorderRadius.circular(100),
                onPressed: () {
                  widget.onActionLeft!();
                },
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(widget.actionLeftIcon),
                // child: Container(
                //     padding: const EdgeInsets.all(14),
                //     child: SvgPicture.asset(widget.actionLeftIcon)
                // ),
              )
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                  visible: widget.onActionRight != null,
                  child: CupertinoButton(
                    // borderRadius: BorderRadius.circular(100),
                    onPressed: () {
                      widget.onActionRight!();
                    },
                    padding: EdgeInsets.zero,
                    child: Text(widget.actionRightIcon, style: MyTextStyles.textStyleMedium17Red),
                    // child: Container(
                    //     padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    //     child: Text(widget.actionRightIcon, style: MyTextStyles.textStyleMedium17Blue)
                    // ),
                  )
              ),
              const SizedBox(width: 10),
              Visibility(
                  visible: widget.onActionEnd != null,
                  child: CupertinoButton(
                    // borderRadius: BorderRadius.circular(100),
                    onPressed: () {
                      widget.onActionEnd!();
                    },
                    padding: EdgeInsets.zero,
                    child: Text(widget.actionEndIcon, style: MyTextStyles.textStyleMedium17Blue),
                    // child: Container(
                    //     padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    //     child: Text(widget.actionRightIcon, style: MyTextStyles.textStyleMedium17Blue)
                    // ),
                  )
              )
            ],
          )
      ),
    );
  }

}