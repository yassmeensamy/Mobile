import 'package:app/Models/ProductModel.dart';

class Restaurant {
  final int id;
  final String name;
  final String image;
  final double rating;
  final double long;
  final double lat;
  final List<Product> products;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.long,
    required this.lat,
    required this.products,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rating: json['rating'].toDouble(),
      long: json['long'].toDouble(),
      lat: json['lat'].toDouble(),
      products: List<Product>.from(
        json['products'].map((productJson) => Product.fromJson(productJson)),
      ),
    );
  }
}