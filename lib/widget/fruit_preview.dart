import 'package:flutter/material.dart';
import '../fruit.dart';
import '../screens/fruit_details_screen.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import 'quantity_badge.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview({
    super.key,
    required this.fruit,
  });

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: fruit.image,
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () => Provider.of<Cart>(context, listen: false).add(fruit),
        ),
        tileColor: fruit.color,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FruitDetailsScreen(
                      fruit: fruit,
                    )),
          );
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(fruit.name),
            Consumer<Cart>(
              builder: (context, cart, child) => QuantityBadge(
                fruit: fruit,
              ),
            ),
          ],
        ));
  }
}
