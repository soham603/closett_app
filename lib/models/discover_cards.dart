import 'package:flutter/material.dart';

class DiscoverCards extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const DiscoverCards(
      {super.key, required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Column(
        children: [
          Container(
            height: 140,
            child: Stack(
              children: [
                Image.network(image),
                // Positioned(
                //     top: 0,
                //     right: 0,
                //     child: IconButton(icon: Icon(Icons.favorite_outline), onPressed: () {},)
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(title),
                  Text(description),
                ],
              ),
              IconButton(icon: Icon(Icons.favorite_outline), onPressed: () {},)
            ],
          ),
        ],
      ),
    );
  }
}