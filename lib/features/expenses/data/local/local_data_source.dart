import 'dart:convert';
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:flutter/services.dart';

import '../../../../core/db/expenses_database.dart';

abstract class LocalDataSource {
  Future<void> save(Expenses expenses);
  Future<Categories> readCategories();
  Future<List<Expenses>> getExpenses(String status);
}

class LocalDataSourceImpl extends LocalDataSource {
  final ExpensesDatabase db;

  LocalDataSourceImpl({ required this.db});

  @override
  Future<void> save(Expenses expenses) async {
    db.insert(expenses);
  }

  @override
  Future<Categories> readCategories() async {
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

  @override
  Future<List<Expenses>> getExpenses(String status) async {
    return await db.query(status);
  }

}