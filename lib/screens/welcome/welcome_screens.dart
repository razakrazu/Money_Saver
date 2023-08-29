import 'package:flutter/material.dart';
import 'package:new_project/screens/bottom_navigegeion/bottom_navigation.dart';

import 'package:new_project/screens/welcome/content_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
 bool _hasSeenwelcomescreen = false;

class _WelcomeScreenState extends State<WelcomeScreen> {
   
  @override
  void initState() {
    super.initState();
    checkIfSeenWelcomescreen();
    _controller= PageController(initialPage: 0);
  }

  void checkIfSeenWelcomescreen() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool hasSeenwelcomescreen =
        preference.getBool('hasSeenwelcomescreen') ?? false;
    setState(() {
      _hasSeenwelcomescreen = hasSeenwelcomescreen;
    });
  }

  void setHasSeenWelcomeScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('hasSeenwelcomescreen', true);
  }
  int currentIndex = 0;
   late PageController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: PageView.builder(
        
        controller: _controller,
        itemCount:contents.length,
        onPageChanged: (int index){
          setState(() {
            currentIndex = index;
          });
        },
        // itemCount: 3,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 170),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Image.asset(contents[i].image),
                ), 
                Padding(
                  padding: const EdgeInsets.only(top: 40 ,left: 50),
                  child: Text(contents[i].title,style: TextStyle( fontSize: 50,color: Colors.blueGrey,),),
                ), 
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                         (index) => buildDot(index,context)),
                    ),
                   
                  ),
                ),
             Padding(
               padding: const EdgeInsets.all(40),
               child: Container(
                   
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                    color:Colors.blueGrey,
                      ),
                     child: TextButton(onPressed: (){
                      setHasSeenWelcomeScreen();
                      if(currentIndex==contents.length-1){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>BottomNavigationScreen()));
                      }
                      _controller.nextPage(duration: Duration(microseconds:100 ), curve: Curves.bounceIn);
                     }, 
                     child: Text(currentIndex==contents.length-1?'continue':'Next',style: TextStyle( fontSize: 17,color: const Color.fromARGB(255, 255, 255, 255),),)),
                  ),
             ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
                       height: 10,
                  width: currentIndex == index? 25 : 10,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).primaryColor,
                  ),
                    );
  }
}
