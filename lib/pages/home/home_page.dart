import 'package:expenses_tracking/config/setting_utils.dart';
import 'package:expenses_tracking/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Text("Lange${Setting.language}"),
        IconButton(onPressed: (){
          setState(() {
            Setting.changeLanguage("km");
          });
        }, icon: const Icon(Icons.chair))
      ],)),
    );
  }
}