import 'package:flutter/material.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';


ValueNotifier<CategoryType>selectedCategoryNotifier = ValueNotifier(CategoryType.income);


Future<void>ShowCategaryPopup(BuildContext context, texteditcntrl) async{
    final nameEditingController =TextEditingController();
showDialog(
  context: context,
   builder: (ctx){
return SimpleDialog(
  title: Text('ADD CATEGORY'),
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: nameEditingController,
        decoration:   const  InputDecoration(
          hintText: 'Categary Name',
          border: OutlineInputBorder(),
        ),
      ),
    ),
  const  Padding(   padding: const EdgeInsets.all(8.0),
   child: Row( children: [
  
      Padding(padding: EdgeInsets.all(8.0)),
  RedioButton(title: 'Income', Type: CategoryType.income),
    RedioButton(title: 'Expense', Type: CategoryType.expense),
    
   ],),),
   Padding(padding: EdgeInsets.all(2.0)),
    Padding(
      padding: const EdgeInsets.all(50),
      child: ElevatedButton(
        onPressed: (){
          final name =nameEditingController.text;
          if(name.isEmpty){
            return;
            
          }
          final  type = selectedCategoryNotifier.value;
        final Category=  CategoryModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
             name: name,
               type: type
               );
             
                  CategoryDB.instince.insetCategory(Category);
           
               Navigator.pop(ctx);
        
                
        }, 
        child: Text('ADD'),),
    )
  ],
);
   });
}
class RedioButton extends StatelessWidget {
  final String title;
  final CategoryType Type;
  const RedioButton({
    Key?key, 
  required this.title,
  required this.Type,});

  
  @override
  Widget build(BuildContext context) {
    return Row(children: [
ValueListenableBuilder(valueListenable: selectedCategoryNotifier,
 builder: (BuildContext ctx, CategoryType newCategary, Widget? _) {
 return Radio<CategoryType>(
  value:Type,
   groupValue: newCategary, 
   onChanged: (value){
    if(value== null){
      return;
    }
     selectedCategoryNotifier.value=value;
    //  selectedCategoryNotifier.notifyListeners();
   if(selectedCategoryNotifier.value==value){
    return;
   }else{
    selectedCategoryNotifier.value=value;
   }
   }
   );}),
   Text(title),
    ],);
  }
}


