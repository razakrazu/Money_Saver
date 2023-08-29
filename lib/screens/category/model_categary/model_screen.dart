
import 'package:hive/hive.dart';
part 'model_screen.g.dart';
@HiveType(typeId: 2)

enum CategoryType{
  @HiveField(0) 
  income,
  @HiveField(1)
  Expense,

}

@HiveType(typeId:1 )
class CategoryModel{

  @HiveField(0)
  final String id;
  
    @HiveField(1)
  final String  name;

    @HiveField(2)
  final bool isdeleted;
  
    @HiveField(3)
  final CategoryType type;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
     this.isdeleted = false
    
  });
}