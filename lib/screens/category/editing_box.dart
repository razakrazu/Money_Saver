// import 'package:flutter/material.dart';
// import 'package:new_project/screens/category/db_category/db_screen.dart';
// import 'package:new_project/screens/category/model_categary/model_screen.dart';



// ValueNotifier<CategoryType> selectedCategoryNotifier =
//     ValueNotifier(CategoryType.income);
// Future<void> editCategoryAddPopup(
//   BuildContext context,
//   // ignore: non_constant_identifier_names
//   {
//   required CategoryModel categoryModel,
//   // required CategoryType categoryType,
//   required int index,
// }) async {
//   final nameController = TextEditingController(text: categoryModel.name);
//   final formKey = GlobalKey<FormState>();

//   showDialog(
//     context: context,
//     builder: (ctx) {
//       return SimpleDialog(
//         title: const Text('Edit your category'),
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Form(
//               key: formKey,
//               child: TextFormField(
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Category item is Empty';
//                   } else {
//                     return null;
//                   }
//                 },
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromARGB(255, 255, 255, 255),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueGrey),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         color: Color.fromARGB(255, 0, 0, 0), width: 1),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueGrey),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueGrey, width: 2),
//                   ),
//                   hintText: 'Category Item',
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 30, right: 30),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blueGrey,
//                 ),
//                 onPressed: () {
//                   final name = nameController.text;
                  
//                   if (formKey.currentState!.validate()) {
//                     final updatedCategory = CategoryModel(
//                       id: categoryModel.id,
//                       name: name,
//                       type: categoryModel.type,
                      
//                     );

//                     CategoryDB.instance.updateCategory(index, updatedCategory,);

//                     Navigator.of(ctx).pop();
//                      ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Category updated'),),);
//                   }
//                 },
//                 child: const Text(
//                   'Update',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       );
//     },
//   );
// }


