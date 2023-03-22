import 'package:flutter/material.dart';

class Fruit {
  final String name;
  final double price;
  final Color color;
  final Image image;

  const Fruit(
      {required this.name,
      required this.price,
      required this.color,
      required this.image});

  factory Fruit.fromJson(json) {
    final hexColor = json['color'].replaceAll('#', '0xff');
    final fruitColor = Color(int.parse(hexColor));
    return Fruit(
      name: json['name'],
      price: json['price'],
      color: fruitColor,
      image: Image.asset('images/${json['image']}'),
    );
  }

  static List<Fruit> fromJsonList(jsonList) {
    List<Fruit> fruits = [];
    jsonList.forEach((json) {
      fruits.add(Fruit.fromJson(json));
    });
    return fruits;
  }
}
