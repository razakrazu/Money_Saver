import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('About Us'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Container(
            height: 220,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Money Saver',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "    Developed by\n\n   ABDUL RAZAK",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Version 1.0.2',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
