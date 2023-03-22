import 'package:flutter/material.dart';
import 'screens/fruit_details_screen.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class FruitWidget extends StatelessWidget {
  const FruitWidget({
    super.key,
    required this.fruit,
  });

  final fruit;

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
      title: Text(fruit.name),
      subtitle: Text('${fruit.price.toString()}€'),
    );
  }
}
