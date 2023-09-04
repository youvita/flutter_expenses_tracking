
import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/bloc/category_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/widget/category_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryFormWidget extends StatefulWidget {
  const CategoryFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryFormState();

}

class _CategoryFormState extends State<CategoryFormWidget> {
  bool isVisible1 = false;
  bool isVisible2 = false;

  @override
  Widget build(BuildContext context) {
    Categories? categories = context.select((CategoryBloc bloc) => bloc.state.categories);

    return Column(
      children: [
        // Flexible(
        Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisible1 = !isVisible1;
                      isVisible2 = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Emoticons", style: MyTextStyles.textStyleMedium17),
                        SvgPicture.asset('assets/images/ic_arrow_drop_down.svg')
                      ],
                    )
                  )
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: CategoryGridviewWidget(
                      isVisible: isVisible1,
                      categories: categories?.emoticons,
                    )
                  )
              ],
            ) // ),
        ),
        Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isVisible2 = !isVisible2;
                      isVisible1 = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Emoticons", style: MyTextStyles.textStyleMedium17),
                      SvgPicture.asset('assets/images/ic_arrow_drop_down.svg')
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(child: CategoryGridviewWidget(
                  isVisible: isVisible2,
                  categories: categories?.dingbats,
                ))
              ],
            ) // ),
        )
      ],
    );
  }

}