import 'package:flutter/material.dart';
import 'shoppingCard.dart';

class PetShoppingList extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'imageUrl': 'https://unsplash.com/photos/w6elADh_jww',
      'name': 'Premium Dog Food',
      'price': 19.99,
      'description': 'A nutritious and delicious blend of meats and vegetables for your furry friend.'
    },
    {
      'imageUrl': 'https://unsplash.com/photos/w6elADh_jww',
      'name': 'Squeaky Dog Toy',
      'price': 5.99,
      'description': 'Hours of fun for your dog with this durable and entertaining toy.'
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Shopping List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];
          return DogProductCard(
            imageUrl: product['imageUrl'],
            name: product['name'],
            price: product['price'],
            description: product['description'],
          );
        },
      ),
    );
  }
}
