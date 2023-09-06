// import 'package:flutter/material.dart';
// import 'package:new_project/screens/category/db_category/db_screen.dart';
// import 'package:new_project/screens/category/expense_screen.dart';
// import 'package:new_project/screens/category/income_screen.dart';
// import 'package:new_project/screens/category/popup_screen.dart';


// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   get texteditcntrl => null;

//   @override
//   void initState() {
//     CategoryDB().refreshUI();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         // drawer:  MenuScreen(),
//         appBar: AppBar(
//           backgroundColor:Colors.blueGrey,
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 text: 'Income',
//               ),
//               Tab(
//                 text: 'Expense',
//               )
//             ],
//             indicatorColor: Color.fromARGB(255, 240, 240, 243),
//           ),
//           title: const Text('Category',style: TextStyle(color: Colors.white, fontSize: 24),),
//           centerTitle: true,
//         ),
//         body: const TabBarView(children: [
//           IncomeScreen(),
//           ExpenseScreen(),
//         ]),
//        floatingActionButton: FloatingActionButton(onPressed: (){
//                    ShowCategaryPopup(context, texteditcntrl);
//        }, child:Icon(Icons.add) ,),
//       ),

//     );
    
//   }
// }
import 'package:flutter/material.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/expense_screen.dart';
import 'package:new_project/screens/category/income_screen.dart';
import 'package:new_project/screens/category/popup_screen.dart';

class ScreenCategogry extends StatefulWidget {
  const ScreenCategogry({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  @override
  State<ScreenCategogry> createState() => _ScreenCategogryState();
}

class _ScreenCategogryState extends State<ScreenCategogry>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  get texteditcntrl => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Category',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 173, 169, 169),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expense',
                  )
                ],
                unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
                labelColor: Color.fromARGB(255, 68, 63, 63),
                indicatorWeight: 4,
                indicatorColor: Color.fromARGB(255, 45, 60, 68),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [IncomeScreen(), ExpenseScreen()],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowCategaryPopup(context, texteditcntrl);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}