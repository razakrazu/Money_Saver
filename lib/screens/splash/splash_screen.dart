import 'package:flutter/material.dart';

import 'package:new_project/screens/welcome/welcome_screens.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
 
     Future.delayed( const Duration(seconds: 5),
      () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => WelcomeScreen(),
            )));       
 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blueGrey,
      body: Center(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            SizedBox(child:Text('MONEY SAVER',style: TextStyle(fontSize: 30,color: Colors.white),),
             
             ),
            Container(
              color: Colors.white,
              child: SizedBox(
                
                ),
            ),
          ],
        ),
      ),),
      
      
    );
  }
}
