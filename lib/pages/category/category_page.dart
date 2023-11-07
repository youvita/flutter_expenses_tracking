import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/pages/category/category_form.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../database/models/category.dart';
import '../../widgets/app_topbar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? image;
    String? name;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppTopBarWidget(
        title: 'New Category'.tr(),
        actionRightIcon: 'Save'.tr(),
        onActionLeft: () {
          Navigator.pop(context);
        },
        onActionRight: () {
          Navigator.pop(context, Category(image ?? '', name ?? ''));
        },
      ),
      backgroundColor: MyColors.white,
      body: CategoryFormWidget(onValueChanged: (Category value) {
        image = value.image;
        name = value.name;
      },
      )
    );
  }

}
