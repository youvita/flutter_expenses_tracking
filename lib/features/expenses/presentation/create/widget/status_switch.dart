import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';

class StatusSwitch extends StatefulWidget {
  final bool value;
  final bool enable;
  final ValueChanged<bool> onChanged;
  const StatusSwitch({Key? key, this.enable = true, required this.value, required this.onChanged}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomSwitchState();

}

class _CustomSwitchState extends State<StatusSwitch> with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight).animate(CurvedAnimation(parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController!, builder: (context, child) {
      return GestureDetector(
        onTap: () {
          if (widget.enable) {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false ? widget.onChanged(true) : widget.onChanged(
                false);
          }
        },
        child: Stack(
            children: [
              Positioned(child: Container(
                width: 288.0,
                height: 36.0,
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.black10, width: 1),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white
                ),
                child: Container(
                    alignment: widget.value ? ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerRight : Alignment.centerLeft ) : ((Directionality.of(context) == TextDirection.rtl) ? Alignment.centerLeft : Alignment.centerRight),
                    child: Container(
                        width: 143.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.rectangle, color: widget.value ? MyColors.red : MyColors.green),
                    )
                ),
              )
              ),
              Positioned(
                  child: SizedBox(
                    width: 288.0,
                    height: 36.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Expense",textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: widget.value ? MyColors.white : MyColors.black
                        )),
                        Text("Income",textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: widget.value ? MyColors.black : MyColors.white
                        ))
                      ],
                    ),
                  )
              )
            ]
        )
      );
    });
  }

}