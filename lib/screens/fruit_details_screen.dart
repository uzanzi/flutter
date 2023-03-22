import 'package:flutter/material.dart';
import 'package:marchand/Fruit.dart';
import 'package:provider/provider.dart';
import '../cart.dart';

class FruitDetailsScreen extends StatelessWidget {
  const FruitDetailsScreen({super.key, required this.fruit});

  final Fruit fruit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(fruit.name))),
      body: Center(
          child: Column(
        children: [
          fruit.image,
          const SizedBox(height: 75),
          Text(fruit.name),
          const SizedBox(height: 75),
          Text('${fruit.price.toString()}€'),
          const SizedBox(height: 75),
          TextButton(
              style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).remove(fruit);
              },
              child: const Text('Supprimer du panier')),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Cart>(context, listen: false).add(fruit),
        tooltip: 'Ajouter au panier',
        child: const Icon(Icons.add),
      ),
    );
  }
}
