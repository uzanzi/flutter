import 'package:flutter/material.dart';
import 'package:marchand/fruit.dart';

class Cart extends ChangeNotifier {
  double _sum = 0;
  double get sum => _sum;

  final List<Fruit> _cart = [];
  List<Fruit> get items => _cart;

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
