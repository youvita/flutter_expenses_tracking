import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/pages/home/list_form.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        color: MyColors.greyBackground,
        child: const ListFormWidget(),
      ),
    );
  }
}