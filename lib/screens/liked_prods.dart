import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/models/saved_prod.dart';
import 'package:provider/provider.dart';

class SavedProducts extends StatelessWidget {
  const SavedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var savedProductsModel = Provider.of<SavedProductsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Products"),
      ),
      body: ListView.builder(
        itemCount: savedProductsModel.savedProducts.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> product = savedProductsModel.savedProducts[index];
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 130,
                  child: Image.network(product['image']),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 5, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 88,
                            margin: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Text(product['title']),
                                Text(product['description']),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Remove the product from the saved list
                              savedProductsModel.removeFromSavedProducts(product);
                            },
                            icon: const Icon(Icons.favorite, color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
