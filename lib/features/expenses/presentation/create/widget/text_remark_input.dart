import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/widgets/divider_widget.dart';
import 'package:flutter/material.dart';

class TextRemarkInputWidget extends StatefulWidget {
  final String label;
  final String placeholder;
  final String value;
  final double horSpace;
  final bool isVisible;
  final ValueChanged<String> onValueChanged;

  const TextRemarkInputWidget({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.value,
    this.horSpace = 8,
    this.isVisible = false,
    required this.onValueChanged
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _TextRemarkInputState();

}

class _TextRemarkInputState extends State<TextRemarkInputWidget> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
  }

  void _runExpandCheck() {
    if(widget.isVisible) {
      expandController.forward();
    }
    else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(TextRemarkInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.label, style: MyTextStyles.textStyleMedium17),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    key: const Key('createForm_remarkInput_textField'),
                    onChanged: (amount) => {
                      widget.onValueChanged(amount)
                    },
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        hintText: "Enter here",
                        border: InputBorder.none,
                        isCollapsed: true
                    ),
                    keyboardType: TextInputType.text,
                    style: MyTextStyles.textStyleBold17,
                  ),
                ]
            ),
          ),
          const DividerWidget()
        ],
      ),
    );
  }

}