import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItemWidget extends StatefulWidget {
  final String image;
  final String label;
  final bool enable;
  final ValueChanged<String> onValueChanged;

  const CategoryItemWidget({
    Key? key,
    this.enable = true,
    required this.image,
    required this.label,
    required this.onValueChanged
  }): super(key: key);

  @override
  State<StatefulWidget> createState() =>_CategoryItemState();

}

class _CategoryItemState extends State<CategoryItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 85,
          width: 85,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    if (widget.enable) {
                      widget.onValueChanged('${widget.image} ${widget.label}');
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: widget.image.isNotEmpty ? Text(widget.image, style: const TextStyle(fontSize: 30),
                      ) : SvgPicture.asset('assets/images/ic_more_horiz.svg')
                  )
              )),
        ),
        const SizedBox(height: 12),
        Text(widget.label, style: MyTextStyles.textStyleNormal15)
      ],
    );
  }

}