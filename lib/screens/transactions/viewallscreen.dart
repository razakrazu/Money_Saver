import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:new_project/screens/Static/chart/chart_db.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'package:new_project/screens/home/balance.dart';
import 'package:new_project/screens/transactions/addtransaction.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';
import 'package:new_project/screens/transactions/edit_transaction.dart';
import 'package:new_project/screens/transactions/model/transaction_model.dart';


class VeiwAllScreen extends StatefulWidget {

  @override
  State<VeiwAllScreen> createState() => _VeiwAllScreenState();
}

class _VeiwAllScreenState extends State<VeiwAllScreen> {
  TextEditingController searchController = TextEditingController();
  var clearcntrl = TextEditingController();
  ValueNotifier<bool> clearButtonNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    clearcntrl.dispose();
    clearButtonNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTransaction()));
      },child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor:Colors.blueGrey ,
        title: const Text('Transactions',     style: TextStyle(color: Colors.white,fontSize: 24),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showPopupMenu1();
              },
              icon: const Icon(Icons.filter_list)),
          IconButton(
              onPressed: () {
                showPopupMenu();
              },
              icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ValueListenableBuilder<bool>(
                  valueListenable: clearButtonNotifier,
                  builder: (context, valuebool, child) => Card(
                    elevation: 9,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            controller: clearcntrl,
                            onChanged: (value) {
                              TransactionDb.instance.search(value);

                              if (value.isEmpty) {
                                clearButtonNotifier.value = false;
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                clearButtonNotifier.notifyListeners();
                              } else {
                                clearButtonNotifier.value = true;
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                clearButtonNotifier.notifyListeners();
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                // color: textClr,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: clearButtonNotifier.value,
                            child: IconButton(
                              onPressed: () {
                                clearcntrl.clear();
                                setState(() {
                                  clearButtonNotifier.value = false;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDb.instance.transactionListNotifier,
            builder:
                (BuildContext ctx, List<TranscationModel> newList, Widget? _) {
              return Expanded(
                  child:
                   newList.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (ctx, index) {
                            final value = newList[index];
                            return Slidable(
                              key: Key(value.id!),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        showAlert(context, index);
                                      },
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTransaction(
                                                      data: value,
                                                      id: index,
                                                    )));
                                      },
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    )
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                         color: Color.fromARGB(255, 211, 209, 209),
                                  elevation: 1,
                                  child: ListTile(
                                    shape: const StadiumBorder(),
                                    leading: value.type == CategoryType.income
                                        ? CircleAvatar(
                                          radius: 23,
                                          backgroundColor: Colors.green, 
                                          child: const Icon(
                                              Icons.arrow_upward,
                                              color: Color.fromARGB(255, 67, 77, 67),
                                            ),
                                        )
                                        : CircleAvatar(
                                          radius: 23,
                                          backgroundColor:  Colors.red,
                                          child: const Icon(
                                           
                                              Icons.arrow_downward,
                                              color: Color.fromARGB(255, 85, 71, 71),
                                            ),
                                        ),
                                    title: Text(value.category.name),
                                    subtitle: Text('Rs:${value.amount}'),
                                    trailing: Text(
                                      parseDate(value.date),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          // ignore: prefer_is_empty
                          itemCount: newList.length)
                      : 
                      Center(child: SizedBox(child: Text('Add Transaction'),)),
             
                        );
            },
          )
        ],
      ),
    );
  }

  void showAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Delete',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            content: const Text(
                'Do you want to delete',),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No",)),
              TextButton(
                  onPressed: () {
                    TransactionDb.instance.deletTransaction(index);
                    Navigator.of(ctx).pop();

                    balanceAmount();
                    TransactionDb.instance.refresh();
                    filterFunction();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  void showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('all');
            },
            child: const Text(
              'All',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('today');
            },
            child: const Text(
              'Today',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('yesterday');
            },
            child: const Text(
              'Yesterday',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('last week');
            },
            child: const Text(
              'Last Week',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
      ],
      // elevation: 8.0,
    );
  }

  void showPopupMenu1() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filter('All');
              TransactionDb.instance.refresh();
            },
            child: const Text(
              'All',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filter('Income');
            },
            child: const Text(
              'Income',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filter('Expense');
            },
            child: const Text(
              'Expense',
              style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.blueGrey,),
            )),
      ],
      elevation: 8.0,
    );
  }

  String parseDate(DateTime date) {
    final ddate = DateFormat.MMMd().format(date);
    final splitedDate = ddate.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }
}
