import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intern_asgn_persist/screens/chats.dart';
import 'package:intern_asgn_persist/screens/discover.dart';
import 'package:intern_asgn_persist/screens/group_screen.dart';
import 'package:intern_asgn_persist/screens/home_screen.dart';
import 'package:intern_asgn_persist/screens/liked_prods.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  State<ScreenController> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const Group_screen(),
    const Discover(),
    const SavedProducts(),
    const ChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Closet",
        useSafeArea: true,
        labels: const ["Closet", "Groups", "Discover", "Saved", "Chats"],
        icons: const [
          FontAwesomeIcons.circleUser,
          FontAwesomeIcons.peopleGroup,
          FontAwesomeIcons.house,
          FontAwesomeIcons.gratipay,
          FontAwesomeIcons.comment,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        //tabIconColor: Colors.blue[600],
        tabIconColor: Colors.white,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.black54,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.blue,
        onTabItemSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: screens[currentIndex],
    );
  }
}
