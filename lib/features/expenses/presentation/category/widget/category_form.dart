
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/bloc/category_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/widget/category_gridview.dart';
import 'package:expenses_tracking/widgets/text_Input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant/constant.dart';
import '../../../../../widgets/divider_widget.dart';
import '../../../../../widgets/text_select.dart';
import '../../../data/model/category.dart';

class CategoryFormWidget extends StatefulWidget {
  const CategoryFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryFormState();

}

class _CategoryFormState extends State<CategoryFormWidget> {

  @override
  Widget build(BuildContext mainContext) {
    Categories? categories = mainContext.select((CategoryBloc bloc) => bloc.state.categories);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const SizedBox(height: 40),
            _CategoryImageWidget(
                onSelected: (bool value) {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                      context: mainContext,
                      builder: (BuildContext context
                          ) {
                        return Column(
                          children: [
                            const SizedBox(height: 4),
                            Card(
                              elevation: 0,
                              color: MyColors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: const SizedBox(width: 60, height: 8),
                            ),
                            Flexible(child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: [
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: const Text("Emoticons", style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.emoticons,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: const Text("Dingbats", style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.dingbats,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: const Text("Transports", style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.transports,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: const Text("Foods", style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.foods,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: const Text("Animals", style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.animals,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: const Text("Other", style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.other,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }))

                          ],
                        );
                      });
                }
            ),
            const DividerWidget(),
            _CategoryNameWidget(),
            const DividerWidget()
          ],
        ),
        _SaveButton()
      ],
    );
  }
}


class _CategoryImageWidget extends StatefulWidget {
  final Function onSelected;

  const _CategoryImageWidget({Key? key, required this.onSelected}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryImageState();
}

class _CategoryImageState extends State<_CategoryImageWidget> {

  @override
  Widget build(BuildContext context) {
    String? categoryImage = context.select((CategoryBloc bloc) => bloc.state.image);

    return TextSelectWidget(
        label: "Image",
        value: categoryImage ?? "Select",
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (bool value) {
          widget.onSelected(value);
        });
  }

}

class _CategoryNameWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryNameState();
}

class _CategoryNameState extends State<_CategoryNameWidget> {

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
        label: "Name",
        onValueChanged: (String value) {
          context.read<CategoryBloc>().add(CategoryNameChanged(value));
        }
    );
  }
}

class _SaveButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String? image = context.select((CategoryBloc bloc) => bloc.state.image);
    String? name = context.select((CategoryBloc bloc) => bloc.state.name);

    return Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          key: const Key('createForm_saveButton'),
          style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
              )
          ),
          onPressed: () {
            Navigator.pop(context, Category(image ?? "", name ?? ""));
          },
          child: const Text('Save', style: MyTextStyles.textStyleMediumWhite15),
        )
    );
  }
}
