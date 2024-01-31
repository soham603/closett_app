import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intern_asgn_persist/models/discover_cards.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

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
        toolbarHeight: 60,
        title: const Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.60,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 15,),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Text('Filters & Sort', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(FontAwesomeIcons.x)),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50,),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Suggested',  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                  IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.plus)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Followers',  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                  IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.plus)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Following', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
                  IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.plus)),
                ],
              ),
            ),

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

                    return Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiscoverCards(
                                image: data['image'],
                                title: data['title'],
                                description: data['description'],
                                productData: data,
                              ),
                            ),
                          );
                        },
                        child: DiscoverCards(
                          image: data['image'],
                          title: data['title'],
                          description: data['description'],
                          productData: data,
                        ),
                      ),
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

