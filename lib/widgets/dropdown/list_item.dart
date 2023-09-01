import 'package:flutter/material.dart';

class ListItem<T> extends StatelessWidget {
  final String title;
  final T? value;
  final VoidCallback? onTap;

  const ListItem(
      this.title, {
        Key? key,
        this.value,
        this.onTap,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title),
        ),
      ),
    );
  }
}