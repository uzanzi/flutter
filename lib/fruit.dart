import 'package:flutter/material.dart';

class Fruit {
  final String name;
  final double price;
  final Color color;
  final Image image;
  final String season;
  final dynamic origin;

  const Fruit({
    required this.name,
    required this.price,
    required this.color,
    required this.image,
    required this.origin,
    required this.season,
  });

  factory Fruit.fromJson(json) {
    final hexColor = json['color'].replaceAll('#', '0xff');
    final fruitColor = Color(int.parse(hexColor));
    return Fruit(
        name: json['name'],
        price: json['price'],
        color: fruitColor,
        image: Image.asset('images/${json['image']}'),
        season: json['season'],
        origin: json['origin']);
  }

  static List<Fruit> fromJsonList(jsonList) {
    List<Fruit> fruits = [];
    jsonList.forEach((json) {
      fruits.add(Fruit.fromJson(json));
    });
    return fruits;
  }

  int countInCart(List<Fruit> cart) {
    int count = 0;
    for (Fruit item in cart) {
      if (item.name == name) {
        count++;
      }
    }
    return count;
  }
}
