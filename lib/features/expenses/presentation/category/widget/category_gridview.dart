
import 'package:flutter/material.dart';

import '../../../../../config/utils.dart';

class CategoryGridviewWidget extends StatefulWidget {
  final List<String>? categories;
  final ValueChanged<String>? onValueChanged;

  const CategoryGridviewWidget({Key? key, required this.categories, this.onValueChanged}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryGridviewState();
}

class _CategoryGridviewState extends State<CategoryGridviewWidget> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemCount: widget.categories?.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Align(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    widget.onValueChanged!(Utils().getUnicodeCharacter("${widget.categories?.elementAt(index)}"));
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
        });
  }

}