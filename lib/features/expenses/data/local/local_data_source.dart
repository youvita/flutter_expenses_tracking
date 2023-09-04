import 'dart:convert';
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:flutter/services.dart';

import '../../../../core/db/expenses_database.dart';

abstract class LocalDataSource {
  Future<void> save(Expenses expenses);
  Future<Categories> readJson();
}

class LocalDataSourceImpl extends LocalDataSource {
  final ExpensesDatabase db;

  LocalDataSourceImpl({ required this.db});

  @override
  Future<void> save(Expenses expenses) async {
    db.insert(expenses);
  }

  @override
  Future<Categories> readJson() async {
    List<dynamic> cateEmoticons = [];
    List<dynamic> cateDingbats = [];
    List<dynamic> cateTransport = [];

    final String response = await rootBundle.loadString('assets/files/categories.json');
    final data = await json.decode(response);
    cateEmoticons = data["categories"][0]["emoticons"];
    cateDingbats = data["categories"][1]["dingbats"];
    cateTransport = data["categories"][2]["transport"];

    List<String> emoticons = cateEmoticons.map((e) => e.toString()).toList();
    List<String> dingbats = cateDingbats.map((e) => e.toString()).toList();
    List<String> transport = cateTransport.map((e) => e.toString()).toList();

    var category = Categories(emoticons: emoticons, dingbats: dingbats, transport: transport);
    return category;
  }

}