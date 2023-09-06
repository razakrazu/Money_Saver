
// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';

const CATEGORY_DB_NAME = 'categary-database ';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategory();
  Future<void> insetCategory(CategoryModel value);
  Future<void> deleteCategary(String CategaryID);
  
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB.internal();
  static CategoryDB instince = CategoryDB.internal();
  factory CategoryDB() {
    return instince;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  Future<void> insetCategory(CategoryModel value) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDB.put(value.id, value);
    refreshUI();
    // Check if a category with the same name exists
    final existingCategory = CategoryDB.values.firstWhere(
      (category) => category.name == value.name,
    );

    if (existingCategory == true) {
      await CategoryDB.put(value.id, value);
      refreshUI();
    }
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return CategoryDB.values.toList();
  }

  // ignore: duplicate_ignore
  Future<void> refreshUI() async {
    final allCategory = await getCategory();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    Future.forEach(allCategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListener.value.add(category);
      } else {
        expenseCategoryListListener.value.add(category);
      }
    });
    // ignore: invalid_use_of_protected_member
    incomeCategoryListListener.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategary(String CategaryID) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDB.delete(CategaryID);
    refreshUI();
  }


  Future updateCategory(int id, CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(id, value);
    refreshUI();
  }

 clearAllData() async {
     final db = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await db.clear();
    await refreshUI();
  }
  }



 
