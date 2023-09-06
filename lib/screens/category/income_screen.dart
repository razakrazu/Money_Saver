
// import 'package:flutter/material.dart';
// import 'package:new_project/screens/category/model_categary/model_screen.dart';
// import 'db_category/db_screen.dart';

// class IncomeScreen extends StatelessWidget {
//   const IncomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: CategoryDB().incomeCAtegoryListListener, 
//       builder: (BuildContext ctx, List<CategoryModel>newlist, Widget? _){
//       return       ListView.separated(
//                 itemBuilder: (ctx,index){
//                   final category = newlist[index];
//               return 
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
//                   child: Card(
//                      color: Color.fromARGB(255, 211, 209, 209),
//                       child: ListTile(title:Text(category.name), 
//                       trailing:IconButton(
//                         onPressed: (){
                    
//                       showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(

// backgroundColor:Color.fromARGB(255, 255, 255, 255) ,          
// title:const  Row(
//             children: [
//               Text('Delete',
//                   style: TextStyle(
//                       fontFamily: 'inder', fontWeight: FontWeight.w500)),
//             ],
//           ),
//           content: SizedBox(
//             height: 70,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Do you  want to delete',
//                   style: TextStyle(fontFamily: 'inder'),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           'Cancel',
//                           style: TextStyle(fontSize: 15),
//                         )),
//                     TextButton(
//                         onPressed: () {
//                              CategoryDB.instance.deleteCategory(category.id);
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Ok', style: TextStyle(fontSize: 15)))
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       });
//                         }, icon: Icon(Icons.delete),) ,),
//                     ),
//                 );
              
//                 }, separatorBuilder: (ctx,index){
//               return SizedBox(height: 2, );
//                 }, 
//                 itemCount:newlist.length);
//     });
// }
// }




import 'package:flutter/material.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';


class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return newList.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: newList.length > 300 ? 3 : 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 120),
                  itemBuilder: (ctx, index) {
                    final category = newList[index];
                    return Card(
                      
                      margin: const EdgeInsets.all(16),
                      elevation: 40,
                      shadowColor: Colors.black,
                      color: const Color.fromARGB(255, 211, 209, 209),
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: const TextStyle(fontSize: 15),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showAlert(context, index);
                            },
                            icon: const Icon(Icons.close)),
                      ),
                    );
                  },
                  itemCount: newList.length)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "  No transactions yet !",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  void showAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Delete ${CategoryDB().incomeCategoryListListener.value[index].name}',
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                    CategoryDB.instince.deleteCategary(CategoryDB()
                        .incomeCategoryListListener
                        .value[index]
                        .id);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}
