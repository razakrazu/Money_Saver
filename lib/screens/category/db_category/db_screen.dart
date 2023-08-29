
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategory();
  Future<void> insetCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
  // Future<void> updateCategory(int index, CategoryModel value); // New method
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB.internal();
  static CategoryDB instance = CategoryDB.internal();
  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  Future<void> insetCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

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
  
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(categoryId);
    refreshUI();
  }

  Future<void> clearAllData() async {
    final db = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await db.clear();
    await refreshUI();
  }

  // @override
  // Future<void> updateCategory(int value, CategoryModel index) async {
  //   final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  //   await categoryDB.putAt(value, index); // Update category at the specified index
  //   refreshUI();
  // }

}
