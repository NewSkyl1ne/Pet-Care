import 'package:flutter/material.dart';

class DogProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final String description;

  DogProductCard({required this.imageUrl, required this.name, required this.price, required this.description});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                     // Navigate to a new screen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('Product Details'),
                          ),
                          body: Center(
                            child: Text('This is the product details screen'),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
