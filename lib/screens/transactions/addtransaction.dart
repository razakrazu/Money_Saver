import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'package:new_project/screens/home/balance.dart';
import 'package:new_project/screens/static/db_static/chart_db.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';
import 'package:new_project/screens/transactions/model/transaction_model.dart';


class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key, required List<TranscationModel> transactions}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String currentDate = DateFormat("dd-MMMM-yyyy").format(DateTime.now());
  int? value = 1;
  final noteEditcntrl = TextEditingController();
  final amountEditingcntrl = TextEditingController();
  final formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  CategoryType? selectedCategoryType = CategoryType.income;
  CategoryModel? selectedcategoryModel;
  String? _categoryID;

  @override
  Widget build(BuildContext context) {
    CategoryDB.instince.refreshUI();
    TransactionDb.instance.refresh();
    filterFunction();
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Add Transaction'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blueGrey,
                            value: CategoryType.income,
                            groupValue: selectedCategoryType,
                            onChanged: (newvalue) {
                              setState(() {
                                selectedCategoryType = CategoryType.income;
                                _categoryID = null;
                              });
                            },
                          ),
                          const Text(
                            'Income',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blueGrey,
                            value: CategoryType.expense,
                            groupValue: selectedCategoryType,
                            onChanged: (newvalue) {
                              setState(() {
                                selectedCategoryType = CategoryType.expense;
                                _categoryID = null;
                              });
                            },
                          ),
                          const Text(
                            'Expense',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 35),
                    child: TextFormField(
                      controller: noteEditcntrl,
                      decoration: const InputDecoration(
                        hintText: 'Enter the purpose',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: Container(
                          width: 330,
                          height: 58,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              underline: Container(),
                              hint: const Text('Select Category'),
                              value: _categoryID,
                              items: (selectedCategoryType ==
                                          CategoryType.income
                                      ? CategoryDB().incomeCategoryListListener
                                      : CategoryDB()
                                          .expenseCategoryListListener)
                                  .value
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    selectedcategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  _categoryID = selectedValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 33),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amountEditingcntrl,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Enter The Amount',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            amountEditingcntrl.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, top: 10, right: 23),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      width: 325,
                      height: 58,
                      child: TextButton.icon(
                        onPressed: () async {
                          final selectedDatetemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30)),
                            lastDate: DateTime.now(),
                          );

                          if (selectedDatetemp == null) {
                            return;
                          } else {
                            stdout.write(selectedDatetemp.toString());
                            setState(() {
                              selectedDate = selectedDatetemp;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        label: Text(
                          selectedDate == null
                              ? currentDate
                              : DateFormat("dd-MMMM-yyyy")
                                  .format(selectedDate!),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shadowColor: Colors.black,
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          addTransaction();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addTransaction() async {
    if (selectedDate == null) {
      selectedDate = DateTime.now();
    }
    final noteText = noteEditcntrl.text;
    final amount = amountEditingcntrl.text;
    print(currentDate);
    print(selectedDate);
    if (noteText.isEmpty ||
        amount.isEmpty ||
        _categoryID == null ||
        selectedDate == null) {
      addingFailed();
      return;
    }

    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      addingFailed();
      return;
    }

    if (selectedcategoryModel == null) {
      addingFailed();
      return;
    }

    final model = TranscationModel(
      note: noteText.trim(),
      amount: parsedAmount,
      date: selectedDate!,
      type: selectedCategoryType!,
      category: selectedcategoryModel!,
    );

    await TransactionDb.instance.addTransaction(model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
    balanceAmount();
    TransactionDb.instance.refresh();
    filterFunction();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data Added Successfully"),
        backgroundColor: Colors.green,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void addingFailed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill in all the required fields!"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: 2),
      ),
    );
  }
}







