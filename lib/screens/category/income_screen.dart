// import 'package:flutter/material.dart';
// import 'package:new_project/screens/category/model_categary/model_screen.dart';
// import 'db_category/db_screen.dart';

// class IncomeScreen extends StatelessWidget {
//   const IncomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: CategoryDB().incomeCategoryListListener,
//         builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
//           return ListView.separated(
//               itemBuilder: (ctx, index) {
//                 final category = newlist[index];
//                 return Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, right: 15, top: 10),
//                     child: Card(
//                       color: Color.fromARGB(255, 211, 209, 209),
//                       child: ListTile(
//                         title: Text(category.name),
//                         trailing: IconButton(
//                           onPressed: () {
                          
//                             showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 backgroundColor:
//                                     Color.fromARGB(255, 255, 255, 255),
//                                 title: const Row(
//                                   children: [
//                                     Text('Delete',
//                                         style: TextStyle(
//                                             fontFamily: 'inder',
//                                             fontWeight: FontWeight.w500)),
//                                   ],
//                                 ),
//                                 content: SizedBox(
//                                   height: 70,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'Do you  want to delete',
//                                         style: TextStyle(fontFamily: 'inder'),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: const Text(
//                                                 'Cancel',
//                                                 style: TextStyle(fontSize: 15),
//                                               )),
//                                           TextButton(
//                                               onPressed: () {
//                                                 CategoryDB.instance
//                                                     .deleteCategory(
//                                                         category.id);
//                                                 Navigator.pop(context);
//                                               },
//                                               child: const Text('Ok',
//                                                   style:
//                                                       TextStyle(fontSize: 15)))
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }
//                             );

//                           },
//                           icon: Icon(Icons.delete),
//                         ),
//                       ),
//                     ),
//                   );
//               },
//               separatorBuilder: (ctx, index) {
//                 return SizedBox(
//                   height: 2,
//                 );
//               },
//               itemCount: newlist.length);
//         });
//   }
// }



import 'package:flutter/material.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'db_category/db_screen.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({Key? key}) : super(key: key); // Fix the constructor

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CategoryModel>>( // Added the generic type
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Card(
                    color: Color.fromARGB(255, 211, 209, 209),
                    child: ListTile(
                      title: Text(category.name),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                title: const Text(
                                  'Delete',
                                  style: TextStyle(fontFamily: 'inder', fontWeight: FontWeight.w500),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min, // Adjusted mainAxisSize
                                  children: [
                                    const Text(
                                      'Do you want to delete this category?',
                                      style: TextStyle(fontFamily: 'inder'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            CategoryDB.instance.deleteCategory(category.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Ok',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 2,
                );
              },
              itemCount: newlist.length);
        });
  }
}
