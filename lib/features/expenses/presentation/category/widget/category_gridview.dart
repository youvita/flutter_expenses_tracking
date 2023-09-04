
import 'package:flutter/material.dart';

import '../../../../../config/utils.dart';

class CategoryGridviewWidget extends StatefulWidget {
  final List<String>? categories;
  final bool isVisible;

  const CategoryGridviewWidget({Key? key, required this.categories, required this.isVisible}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryGridviewState();
}

class _CategoryGridviewState extends State<CategoryGridviewWidget> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(CategoryGridviewWidget oldWidget) {
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
      axisAlignment: 1.0, sizeFactor: animation,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemCount: widget.categories?.length,
          itemBuilder: (BuildContext context, int index) {
            return Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {

                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Text(
                    Utils().getUnicodeCharacter("${widget.categories?.elementAt(index)}"),
                    style: const TextStyle(
                        fontSize: 30
                    ),
                    textAlign: TextAlign.center,
                  )
              )
            );
          })
    );
  }

}