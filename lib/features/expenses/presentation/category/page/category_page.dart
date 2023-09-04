
import 'package:expenses_tracking/features/expenses/presentation/category/bloc/category_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/widget/category_form.dart';
import 'package:expenses_tracking/widgets/app_topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/injection_container.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBarWidget(
        title: "New Category", onActionRight: () {},
      ),
      body: BlocProvider(
        create: (_) => sl<CategoryBloc>()..add(const CategoriesState()),
        child: const CategoryFormWidget(),
      ),
    );
  }
  
}