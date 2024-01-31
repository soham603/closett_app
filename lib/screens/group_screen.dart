import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/screens/add_prod.dart';
import 'package:intern_asgn_persist/screens/chats.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class Group_screen extends StatefulWidget {
  const Group_screen({super.key});

  @override
  State<Group_screen> createState() => _Group_screenState();
}

class _Group_screenState extends State<Group_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Padding(
          padding: EdgeInsets.only(left: 2, top: 10),
          child: Text(
            'Groups',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        actions: [
          GlowingAddButton1(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 25,
                child: TextField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Search ...",
                    alignLabelWithHint: false,

                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Adjust the vertical padding
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
        Container(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.account_circle, size: 50),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: OnlineIndicator(
                        isOnline: false,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text('Group 1'),
                  subtitle: Text('User1, User2, User3, Soham Lad'),
                  onTap: () {
                    // Implement navigation to chat screen with selected user
                    // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(user: userData)));
                  },
                ),
              ),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}

class GlowingAddButton1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadVideo()));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 22),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: CupertinoColors.systemPink.withOpacity(0.5),
          child: Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 254, 199, 246),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemPink.withOpacity(0.5),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: CupertinoColors.systemPink,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Create New',
                    style: TextStyle(
                      color: CupertinoColors.systemPink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}