import 'package:flutter/material.dart';
import 'package:new_project/screens/bottom_navigegeion/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _cotrolusername=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF607D8B) ,

      
      body: SafeArea(
        
        child:
      Container(
        
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child:   Container(
                       height: 150,
                       width: 600,
                  child : const  Padding(
                    padding: const EdgeInsets.only(),
                    child: Image(image: AssetImage('assets/loan_10726288.png'),),
                  ),
                  
              ),
            ),
      
            Expanded(
              child: ListView(
                
                children:[
                  
              const      Padding(
                    padding: const EdgeInsets.only( top:120,left: 30,right:20  ),
                    child: const  Text('Simple way to\n    help control\n        your savings',  style:TextStyle(fontSize: 40,color: Colors.black),),
                  ),
               const     SizedBox(height: 30,),
                   Padding(
                     padding: const EdgeInsets.only(left: 20,right: 30),
                     child: Container(
                      decoration: BoxDecoration(
                        color: const  Color.fromARGB(255, 131, 125, 125),
                  borderRadius: BorderRadius.circular(25)
                      ),
                          height:200,
                          
                          
                         child: Column(
                           
                               // mainAxisAlignment: MainAxisAlignment.,
                               children: [
                const         Padding(
                         padding: const EdgeInsets.only(top:30),
                      
                       ),
                       const   SizedBox( height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 50,right: 50,),
                          child: TextFormField(
                            controller: _cotrolusername,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const  BorderSide(),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: 'enter your name',
                              hintStyle: const  TextStyle(fontSize: 15,color: Colors.black),
                                border: OutlineInputBorder(borderRadius:BorderRadius.circular(100) ),
                                contentPadding: const   EdgeInsets.symmetric(
                          vertical: 0,horizontal: 24
                                )
                            ),
                        
                          ),
                        ),
                       
                           Container(
                            width: 200,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25,right: 25 ,top: 10),
                              child: ElevatedButton(onPressed: (){
                                checkUserName();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
                              ),
                               child: const  Text('Start')),
                            ),
                          ),
                              
                               ],
                             ),
                     ),
                   ),
              ],
              ),
            ),
          ],
        ),
      ), ),
    );
  }
  void checkUserName() async {
    if (_cotrolusername.text == '') {
      const snackBar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          'Please enter your name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('nameKey', _cotrolusername.text);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  const  BottomNavigationScreen()));
    }
  }
}