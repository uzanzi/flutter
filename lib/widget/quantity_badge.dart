import 'package:flutter/material.dart';
import 'package:marchand/fruit.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class QuantityBadge extends StatelessWidget {
  const QuantityBadge({
    super.key,
    required this.fruit,
  });

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Consumer<Cart>(
        builder: (context, cart, child) =>
            Text(fruit.countInCart(cart.items).toString()),
      ),
      backgroundColor: Colors.red,
    );
  }
}
