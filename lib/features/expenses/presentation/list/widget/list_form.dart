

import 'package:flutter/cupertino.dart';

class ListFormWidget extends StatefulWidget {
  const ListFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ListFormState();

}

class _ListFormState extends State<ListFormWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Text("data");
        }
    );
  }

}