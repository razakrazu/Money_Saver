import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:new_project/screens/Static/chart/chart_db.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'package:new_project/screens/home/balance.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';
import 'package:new_project/screens/transactions/edit_transaction.dart';
import 'package:new_project/screens/transactions/model/transaction_model.dart';


class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
      List<TranscationModel> transactions = [];

  @override
  Widget build(BuildContext context) {

     TransactionDb.instance.refresh();
      CategoryDB.instance.refreshUI();
    filterFunction();

    return Scaffold(

      body: SafeArea(                   
        child:  Column(
          children:<Widget> [
            Expanded(
              child: Stack(
                children: [
                
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration:const BoxDecoration(
                      color:  Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.only(bottom: 200, left: 30),
                      child: Row(
                        children: [
                          Text('Save Money',style: TextStyle(color: Colors.white),),
                          SizedBox(
                            width: 220,
                            height: 1.0,
                          ),
                          Icon(Icons.currency_rupee,color:Color.fromARGB(255, 255, 236, 236), ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    
                    children: [
                      Positioned(
                        top: 116,
                        left: 30,
                        child: Column(
                          children: [
                            Container(
                              height: 260,
                              width: 330,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 173, 169, 169),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Balance Amount',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Icon(
                                          Icons.more_horiz,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30),
                                          child: Text(
                                           totalnotifier.value.toString(),
                                           
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.green,
                                              child: Icon(Icons.arrow_upward),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Income',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 197, 8, 8),
                                              child: Icon(Icons.arrow_downward),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Expense',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                   
                                         incomenotifier.value.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                expensenotifier.value.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
            ),

            Padding(padding: EdgeInsets.only(bottom:0)),
             Expanded( 
              
               child: Stack(
                 children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 7,),
                Row(
                  children: [
                    Text(
                  'All view',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
             
                  ],
                )
              ],
            ),
          ),
                ValueListenableBuilder(
                               valueListenable: TransactionDb.instance.transactionListNotifier,
                               builder:
                        (BuildContext ctx, List<TranscationModel> newList, Widget? _) {
                      transactions = newList;
                      return  
                          // newList.isNotEmpty
                              // ?
                               ListView.separated(
                                padding: const EdgeInsets.only(top:45),

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
                                                ?CircleAvatar(
                                                  radius: 23,
                                                    backgroundColor:  Colors.green,
                                                  child: const Icon(
                                                      Icons.arrow_upward,
                                                color: Color.fromARGB(255, 0, 0, 0),

                                                    ),
                                                )
                                                : CircleAvatar(
                                                  radius: 23,
                                                  backgroundColor:Color.fromARGB(255, 196, 58, 48) ,
                                                  child: const Icon(
                                                      Icons.arrow_downward,
                                                      color: Color.fromARGB(255, 0, 0, 0),
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
                                    return SizedBox(height: 2,);
                                  },
                                  // ignore: prefer_is_empty
                                  itemCount: newList.length > 4 ? 4 : newList.length
                    
                                  );
                              // : Text(''),
                           
                                
                        
                          
                               },
                             ),
                 ], 
               ),
             ), 
          ],
        ),

      ),
    );
  }
   String parseDate(DateTime date) {
    final ddate = DateFormat.MMMd().format(date);
    final splitedDate = ddate.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
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
                'Do you want to delete'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    TransactionDb.instance.deletTransaction(index);
                    Navigator.of(ctx).pop();
                    balanceAmount();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}



