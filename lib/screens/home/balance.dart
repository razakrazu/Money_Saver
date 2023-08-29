
import 'package:flutter/cupertino.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';

ValueNotifier<double> incomenotifier = ValueNotifier(0);
ValueNotifier<double> expensenotifier = ValueNotifier(0);
ValueNotifier<double> totalnotifier = ValueNotifier(0);

Future<void> balanceAmount() async {
  await TransactionDb.instance.getAllTransaction().then((value) {
    incomenotifier.value = 0;
    expensenotifier.value = 0;
    totalnotifier.value = 0;

    for (var item in value) {
      if (item.type == CategoryType.income) {
        incomenotifier.value += item.amount;
      } else {
        expensenotifier.value += item.amount;
      }
    }
    totalnotifier.value = incomenotifier.value - expensenotifier.value;
  });
}
