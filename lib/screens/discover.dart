import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/models/discover_cards.dart';
import 'package:intern_asgn_persist/models/my_outfit.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  Future<List<Map<String, dynamic>>> getAllOutfits() async {
    QuerySnapshot<Map<String, dynamic>> outfitsSnapshot =
    await FirebaseFirestore.instance.collectionGroup('outfits').get();

    List<Map<String, dynamic>> outfitsData = [];
    outfitsSnapshot.docs.forEach((outfitDoc) {
      outfitsData.add(outfitDoc.data());
    });

    return outfitsData;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover"),
        centerTitle: true,
      ),
      drawer: const Drawer(
        width: 240,
        child: Column(
          children: [
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllOutfits(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
            
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
            
                List<Map<String, dynamic>> outfitsData = snapshot.data ?? [];
            
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: outfitsData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = outfitsData[index];
            
                    // Replace with your widget to display outfit data
                    return DiscoverCards(
                      image: data['image'],
                      title: data['title'],
                      description: data['description'],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
