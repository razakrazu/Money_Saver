import 'package:flutter/material.dart';
import 'package:new_project/screens/category/screen_category.dart';
import 'package:new_project/screens/home/home_screen%20copy.dart';
import 'package:new_project/screens/settings/setting_screen.dart';
import 'package:new_project/screens/static/insights.dart';
import 'package:new_project/screens/transactions/viewallscreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  
  List<Widget> _buildScreens() {
    return [
       HomeScreens(),
       VeiwAllScreen(),
      ScreenCategogry(),
      FinancialReport(),
      SettingScreen(),
    ];
  }
  int currentIndex = 0;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 212, 212, 212),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.swap_horiz),
        title: "Transaction",
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 212, 212, 212),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.category),
        title: "Category",
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 212, 212, 212),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.leaderboard),
        title: "Statistics",
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: const Color.fromARGB(255, 212, 212, 212),
      ),
      // Add a dummy item with a placeholder icon
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: Color.fromARGB(255, 212, 212, 212),
      ),
    ];
  }

  get texteditcntrl => null;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 209, 209),
      body: PersistentTabView(
        context,
        controller: controller,

        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: const Color.fromARGB(255, 85, 112, 126),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
     
    );
  }
}

