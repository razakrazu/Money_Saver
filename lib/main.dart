import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_project/screens/category/db_category/db_screen.dart';
import 'package:new_project/screens/category/model_categary/model_screen.dart';
import 'package:new_project/screens/home/balance.dart';
import 'package:new_project/screens/home/model/profile_model.dart';
import 'package:new_project/screens/splash/splash_screen.dart';
import 'package:new_project/screens/transactions/db/transaction_db.dart';
import 'package:new_project/screens/transactions/model/transaction_model.dart';



const SAVE_KEY_NAME='usernameLoggedIn';
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }


  if (!Hive.isAdapterRegistered(TranscationModelAdapter().typeId)) {
    Hive.registerAdapter(TranscationModelAdapter());
  }
   if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
    Hive.registerAdapter(ProfileModelAdapter());
  }

  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.ss
  @override
  Widget build(BuildContext context) {
       CategoryDB.instance.refreshUI();
    TransactionDb.instance.refresh();
 balanceAmount();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blueGrey,
      ),
      home:SplashScreen(),
      
      debugShowCheckedModeBanner: false,
    );
  }
}


