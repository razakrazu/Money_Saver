import 'package:flutter/material.dart';
import 'package:new_project/screens/bottom_navigegeion/bottom_navigation.dart';
import 'package:new_project/screens/welcome/welcome_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blueGrey,
      body: Center(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Container( 
              height: 90,
               child: const   Image(image: AssetImage('assets/wallet_4864209.png')),),
         
     const         SizedBox(child:Text('SPENT SMART',style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 223, 223, 223)),),
             
             ),
            
            Container(
              color: Colors.blueGrey,
              child: const  SizedBox(
                
                ),
            ),
          ],
        ),
      ),),
      
      
    );
  }
   @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (ctx1) => const  WelcomeScreen(),
    ));
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLogged = sharedPrefs.getString('nameKey');
    if (userLogged == null) {
      gotoLogin();
    } else {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx1) => const  BottomNavigationScreen(),
      )
      );
    }
  }
}
