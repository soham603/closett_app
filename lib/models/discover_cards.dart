import 'package:flutter/material.dart';
import 'package:intern_asgn_persist/models/saved_prod.dart';
import 'package:provider/provider.dart';

class DiscoverCards extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final Map<String, dynamic> productData;

  const DiscoverCards({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.productData,
  }) : super(key: key);

  @override
  _DiscoverCardsState createState() => _DiscoverCardsState();
}

class _DiscoverCardsState extends State<DiscoverCards> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    var savedProductsModel = Provider.of<SavedProductsModel>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiscoverCardsDetail(
                image: widget.image,
                title: widget.title,
                description: widget.description,
                productData: widget.productData,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 130,
              child: Image.network(widget.image),
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
                            Text(widget.title),
                            Text(widget.description),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                          });

                          // Access the provider and add/remove the product from saved list
                          if (isPressed) {
                            savedProductsModel.addToSavedProducts(widget.productData);
                          } else {
                            savedProductsModel.removeFromSavedProducts(widget.productData);
                          }
                        },
                        icon: Icon(isPressed ? Icons.favorite : Icons.favorite_outline),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class DiscoverCardsDetail extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final Map<String, dynamic> productData;

  const DiscoverCardsDetail({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.productData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details: $title"),
      ),
      body: Column(
        children: [
          Image.network(image),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(description),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // You can add any specific actions or functionality here
              // For example, you might want to perform some action when the button is pressed
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
