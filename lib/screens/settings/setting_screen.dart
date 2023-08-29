import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:new_project/screens/settings/about_screen.dart';
import 'package:new_project/screens/settings/condition_screen.dart';
import 'package:new_project/screens/settings/privacy_screen.dart';
import 'package:new_project/screens/settings/restart_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info, color: Colors.black, size: 29),
              label: Text(
                'About',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // backgroundColor: graphBlue,
                        title: const Row(
                          children: [
                            Text('Reset',
                                style: TextStyle(
                                    fontFamily: 'inder',
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        content: SizedBox(
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Are you sure want to reset \nentire data?',
                                style: TextStyle(fontFamily: 'inder'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 15),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        resetMM(context);
                                      },
                                      child: const Text('Ok',
                                          style: TextStyle(fontSize: 15)))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.restart_alt_rounded,
                  color: Colors.black, size: 29),
              label: Text(
                'Reset',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: TextButton.icon(
              onPressed: () {
                Share.share('com.example.new_project');
                
              },
              icon: Icon(Icons.share, color: Colors.black, size: 29),
              label: Text(
                'Share',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PrivacyPolicy(),
                  ),
                );
              },
              icon:
                  Icon(Icons.privacy_tip_sharp, color: Colors.black, size: 29),
              label: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        TermsAndConditions(), // Replace with the appropriate screen
                  ),
                );
              },
              icon: Icon(Icons.list_alt_rounded, color: Colors.black, size: 29),
              label: Text(
                'Terms & Conditions',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
