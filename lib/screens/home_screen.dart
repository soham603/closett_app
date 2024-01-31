import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/models/my_outfit.dart';
import 'package:intern_asgn_persist/screens/add_prod.dart';

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
      // drawer: Drawer(
      //   child: ElevatedButton(onPressed: signOut, child: const Text("Signout")),
      // ),
      body: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Container(
          //       child: Column(
          //         children: [
          //           Container(
          //             height: 100,
          //             width: 100,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               border: Border.all(color: Colors.black, width: 3),
          //             ),
          //             child: const Icon(Iconsax.profile_circle),
          //           ),
          //           const Text("Name"),
          //           const Text("user Name"),
          //         ],
          //       ),
          //     ),
          //
          //
          //     Container(
          //       child: Row(
          //         children: [
          //           IconButton(
          //             onPressed: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context) => const UploadVideo()),
          //               );
          //             },
          //             icon: const Icon(Icons.add_circle_outline_outlined, size: 50),
          //           ),
          //           const Text("Add New", style: TextStyle(fontSize: 20)),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),


          Container(
            height: 290,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 15, left: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const Spacer(), // Use Spacer to push the following widget to the end
                      IconButton(
                        onPressed: signOut,
                        icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 25),
                      ),
                    ],
                  ),
                ),

                const Center(
                  child: CircleAvatar(
                    child: Icon(Icons.account_circle, size: 50),
                    radius: 30,
                  ),
                ),
                const SizedBox(height: 5,),
                FutureBuilder(
                  future: getUserDetails(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('User data not available.');
                    }

                    var userData = snapshot.data!.data();
                    String name = userData?['name'] ?? '';
                    String email = userData?['email'] ?? '';

                    return Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          email,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          IconButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadVideo()));
                          }, icon: const Icon(Icons.add_circle_outline_outlined, color: Colors.white,size: 25,)),
                          const Text('Add Outfit', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.white,size: 25,)),
                        const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),



          const SizedBox(height: 10),
          const Text("My Outfits", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
