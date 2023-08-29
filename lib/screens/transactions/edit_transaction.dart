import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_project/screens/Static/chart/chart_db.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'package:new_project/screens/home/balance.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';
import 'package:new_project/screens/transactions/model/transaction_model.dart';


// ignore: must_be_immutable
class EditTransaction extends StatefulWidget {
  TranscationModel data;
  final int id;
  EditTransaction({super.key, required this.data, required this.id});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final noteEditcntrl = TextEditingController();
  TextEditingController amountEditingcntrl = TextEditingController();
  final formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedcategoryModel;
  String? categoryID;

  @override
  void initState() {
    selectedCategoryType = widget.data.type;
    selectedDate = widget.data.date;
    amountEditingcntrl.text = widget.data.amount.toString();
    noteEditcntrl.text = widget.data.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
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
                                  categoryID = null;
                                });
                              }),
                          const Text('Income', style: TextStyle(fontSize: 23),),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: Colors.blueGrey,
                              value: CategoryType.Expense,
                              groupValue: selectedCategoryType,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectedCategoryType = CategoryType.Expense;
                                  categoryID = null;
                                });
                              }),
                          const Text('Expense', style: TextStyle(fontSize: 23),),
                        ],
                      ),
                    ],
                  ),
                   Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 35),
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
              
                  SizedBox(height: 30,),
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
                              value: categoryID,
                              hint: Text(widget.data.category.name),
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: (selectedCategoryType == CategoryType.income
                                      ? CategoryDB().incomeCategoryListListener
                                      : CategoryDB().expenseCategoryListListener
                                      )
                                  .value
                                  .map((e) {
                                return DropdownMenuItem(
                                    onTap: () {
                                      selectedcategoryModel = e;
                                    },
                                    value: e.id,
                                    child: Text(e.name));
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  categoryID = selectedValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                    height: 20,
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 33),
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
                          icon: const Icon(Icons.clear))),
                ),
              ),
              SizedBox(
                    height: 16,
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 10, right: 23),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  width: 325,
                  height: 58,
                  child: TextButton.icon(
                      onPressed: () async {
                        final selectedDatetemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30)),
                            lastDate: DateTime.now());

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
                            ? 'Select Date'
                            : DateFormat("dd-MMMM-yyyy").format(selectedDate!),
                        style: const TextStyle(color: Colors.black),
                      )),
                ),
              ),
         
               SizedBox(
                    height: 33,
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey, shadowColor: Colors.black),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        editTransaction();
                      }
                    },
                    child: const Text(
                      'Update',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future editTransaction() async {
    final noteText = noteEditcntrl.text;
    final amount = amountEditingcntrl.text;
    if (noteText.isEmpty) {
      return addingFailed();
    }
    if (amount.isEmpty) {
      return addingFailed();
    }
    if (categoryID == null) {
      return addingFailed();
    }
    if (selectedDate == null) {
      return addingFailed();
    }
    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      return addingFailed();
    }
    if (selectedcategoryModel == null) {
      return;
    }

    final model = TranscationModel(
        note: noteText.trim(),
        amount: parsedAmount,
        date: selectedDate!,
        type: selectedCategoryType!,
        category: selectedcategoryModel ?? widget.data.category);

    TransactionDb transactionDb = TransactionDb();
    final index = transactionDb.transactionListNotifier.value
        .indexOf(transactionDb.transactionListNotifier.value[widget.id]);
    transactionDb.editTransactionDb(index, model);
    // ignore: use_build_context_synchronously

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
    balanceAmount();
    filterFunction();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Data Added SuccessFully"),
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  void addingFailed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please add the remaining fields!"),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }
}
