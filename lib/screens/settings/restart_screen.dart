import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';
import 'package:new_project/screens/welcome/welcome_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> resetMM(BuildContext ctx) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.clear();
  TransactionDb.instance.clearAllData();
  CategoryDB.instance.clearAllData();
  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx1) => WelcomeScreen(),
      ),
      (route) => false);
}
