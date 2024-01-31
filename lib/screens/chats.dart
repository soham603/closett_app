import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern_asgn_persist/screens/add_prod.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Padding(
          padding: EdgeInsets.only(left: 2, top: 10),
          child: Text(
            'Chats',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        actions: [
          GlowingAddButton(),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }

      if (snapshot.hasError) {
        return Center(
          child: Text('Error: ${snapshot.error}'),
        );
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text('No users available.'),
        );
      }

      // Filter out the current user
      List<DocumentSnapshot<Map<String, dynamic>>> usersList = snapshot.data!.docs
          .where((userDoc) => userDoc.id != FirebaseAuth.instance.currentUser?.uid)
          .toList();

      return Column(
        children: [
          Column(
            children: [
              SizedBox(height: 15,),
              SizedBox(
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
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot<Map<String, dynamic>> userDoc = usersList[index];
                Map<String, dynamic> userData = userDoc.data()!;

                return Container(
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
                          title: Text(userData['name'] ?? 'Unknown'),
                          subtitle: Text(userData['email'] ?? ''),
                          onTap: () {
                            // Implement navigation to chat screen with selected user
                            // For example: Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(user: userData)));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
    ),

    );
  }
}

class GlowingAddButton extends StatelessWidget {
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
            width: 80,
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
                    'New',
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

class OnlineIndicator extends StatelessWidget {
  final bool isOnline;

  const OnlineIndicator({Key? key, required this.isOnline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOnline ? Colors.green : Colors.red,
        border: Border.all(width: 2, color: Colors.white),
      ),
    );
  }
}
