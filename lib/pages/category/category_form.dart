
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/widgets/text_Input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant/constant.dart';
import '../../../../../widgets/divider_widget.dart';
import '../../../../../widgets/text_select.dart';
import '../../database/models/categories.dart';
import '../../database/models/category.dart';
import 'category_gridview.dart';

class CategoryFormWidget extends StatefulWidget {
  const CategoryFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryFormState();

}

class _CategoryFormState extends State<CategoryFormWidget> {
  Categories? categories;
  Category? category;
  Function? callBack;
  static String? image;
  static String? name;

  @override
  initState() {
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    categories = await getCategories();
  }

  @override
  Widget build(BuildContext mainContext) {
    // Categories? categories = mainContext.select((CategoryBloc bloc) => bloc.state.categories);

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
                                        title: Text('Emoticons'.tr(), style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.emoticons,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                image = value;
                                                // mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: Text('Dingbats'.tr(), style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.dingbats,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                image = value;
                                                // category?.imageChange = value;
                                                // mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: Text('Transports'.tr(), style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.transports,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                image = value;
                                                // category?.imageChange = value;
                                                // mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: Text('Foods'.tr(), style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.foods,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                image = value;
                                                // category?.imageChange = value;
                                                // mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: Text('Animals'.tr(), style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.animals,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                image = value;
                                                // category?.imageChange = value;
                                                // mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
                                              });
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        trailing: SvgPicture.asset('assets/images/ic_arrow_drop_down.svg'),
                                        title: Text('Other'.tr(), style: MyTextStyles.textStyleMedium17),
                                        shape: const Border(),
                                        children: <Widget>[
                                          CategoryGridviewWidget(
                                            categories: categories?.other,
                                            onValueChanged: (String value) {
                                              setState(() {
                                                image = value;
                                                // category?.imageChange = value;
                                                // mainContext.read<CategoryBloc>().add(CategoryImageChanged(value));
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
                }, image: image
            ),
            const DividerWidget(),
            _CategoryNameWidget(onTextChange: (String value) {
               setState(() {
                 name = value;
               });
            }),
            const DividerWidget()
          ],
        ),
        _SaveButton(image, name)
      ],
    );
  }
}


class _CategoryImageWidget extends StatefulWidget {
  final Function onSelected;
  final String? image;

  const _CategoryImageWidget({required this.onSelected, required this.image});

  @override
  State<StatefulWidget> createState() => _CategoryImageState();
}

class _CategoryImageState extends State<_CategoryImageWidget> {

  @override
  Widget build(BuildContext context) {
    // String? categoryImage = context.select((CategoryBloc bloc) => bloc.state.image);

    return TextSelectWidget(
        label: 'Image'.tr(),
        value: widget.image ?? 'Select'.tr(),
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (bool value) {
          widget.onSelected(value);
        });
  }

}

class _CategoryNameWidget extends StatefulWidget {

  final ValueChanged<String> onTextChange;

  const _CategoryNameWidget({required this.onTextChange});

  @override
  State<StatefulWidget> createState() => _CategoryNameState();
}

class _CategoryNameState extends State<_CategoryNameWidget> {


  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
        label: 'Name'.tr(),
        placeholder: 'Please Input'.tr(),
        onValueChanged: (String value) {
          widget.onTextChange(value);
          // context.read<CategoryBloc>().add(CategoryNameChanged(value));
        }
    );
  }
}

class _SaveButton extends StatelessWidget {

  final String? image;
  final String? name;

  const _SaveButton(this.image, this.name);

  @override
  Widget build(BuildContext context) {
    // String? image = context.select((CategoryBloc bloc) => bloc.state.image);
    // String? name = context.select((CategoryBloc bloc) => bloc.state.name);

    return SafeArea(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              key: const Key('createForm_saveButton'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.blue,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                  )
              ),
              onPressed: () {
                Navigator.pop(context, Category(image ?? '', name ?? ''));
              },
              child: Text('Save'.tr(), style: MyTextStyles.textStyleMediumWhite15),
            )
        )
    );
  }
}

Future<Categories> getCategories() async {
  List<dynamic> cateEmoticons = [];
  List<dynamic> cateDingbats = [];
  List<dynamic> cateTransports = [];
  List<dynamic> cateFoods = [];
  List<dynamic> cateAnimals = [];
  List<dynamic> cateOther = [];

  final String response = await rootBundle.loadString('assets/files/categories.json');
  final data = await json.decode(response);
  cateEmoticons = data["categories"][0]["emoticons"];
  cateDingbats = data["categories"][1]["dingbats"];
  cateTransports = data["categories"][2]["transports"];
  cateFoods = data["categories"][3]["foods"];
  cateAnimals = data["categories"][4]["animals"];
  cateOther = data["categories"][5]["other"];

  List<String> emoticons = cateEmoticons.map((e) => e.toString()).toList();
  List<String> dingbats = cateDingbats.map((e) => e.toString()).toList();
  List<String> transports = cateTransports.map((e) => e.toString()).toList();
  List<String> foods = cateFoods.map((e) => e.toString()).toList();
  List<String> animals = cateAnimals.map((e) => e.toString()).toList();
  List<String> other = cateOther.map((e) => e.toString()).toList();

  var category = Categories(emoticons: emoticons, dingbats: dingbats, transports: transports, foods: foods, animals: animals, other: other);
  return category;
}
