import 'package:flutter/material.dart';
import 'package:marchand/Fruit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cart extends ChangeNotifier {
  final List<Fruit> _fruits = [];

  double _sum = 0;
  double get sum => _sum;

  final List<Fruit> _cart = [];
  List<Fruit> get items => _cart;

  Future fetchAndSetFruits() async {
    try {
      final fruits = await fetchFruits();
      _fruits.clear();
      _fruits.addAll(fruits);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Fruit>> fetchFruits() async {
    var url = Uri.https('fruits.shrp.dev', 'items/fruits');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Fruit.fromJsonList(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load fruits');
    }
  }

  void add(Fruit fruit) {
    _sum = _sum + fruit.price;
    _cart.add(fruit);
    notifyListeners();
  }

  void remove(Fruit fruit) {
    if (_cart.contains(fruit)) {
      _sum = _sum - fruit.price;
      _cart.remove(fruit);
    }
    notifyListeners();
  }

  void removeAll() {
    _cart.clear();
    _sum = 0;
    notifyListeners();
  }
}
