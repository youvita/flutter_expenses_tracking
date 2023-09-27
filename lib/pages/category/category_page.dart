import 'package:expenses_tracking/pages/category/category_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../widgets/app_topbar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppTopBarWidget(
        title: "New Category", onActionRight: () {
        Navigator.pop(context);
      },
      ),
      backgroundColor: MyColors.white,
      body: const CategoryFormWidget()
    );
  }

}
