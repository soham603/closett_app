import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intern_asgn_persist/auths/auth_page.dart';
import 'package:intern_asgn_persist/screens/add_prod.dart';
import 'package:intern_asgn_persist/models/my_outfit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    try {
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get();
    } catch (e) {
      // Handle errors more gracefully
      print("Error fetching user details: $e");
      rethrow;
    }
  }

  void signOut() async {
    if (currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getUserDetails(),
                builder: (context, snapshot) {
                  // loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // error
                  else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  // data received
                  else if (snapshot.hasData) {
                    // extract data
                    Map<String, dynamic>? user = snapshot.data!.data();
                    if (user == null) {
                      return const Text("Error: User data is null");
                    }
                    return Text(
                      "${user['name']}'s Closet" ?? "No Email",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Text("Unknown error occurred");
                  }
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ElevatedButton(onPressed: signOut, child: const Text("Signout")),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: const Icon(Iconsax.profile_circle),
                    ),
                    const Text("Name"),
                    const Text("user Name"),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UploadVideo()),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline_outlined, size: 50),
                    ),
                    const Text("Add New", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text("My Outfits"),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).collection('outfits').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No Outfits available.'),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set the number of items in a row
                    crossAxisSpacing: 1.0, // Set the spacing between items horizontally
                    mainAxisSpacing: 1.0, // Set the spacing between items vertically
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                    return VideoCard(
                      image: data['image'] ?? '',
                      title: data['title'] ?? '',
                      description: data['description'] ?? '',
                    );
                  },
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}
