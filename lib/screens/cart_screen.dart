import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).removeAll();
              },
            ),
          ],
          title: Center(
            child: Consumer<Cart>(
              builder: (context, cart, child) => Text("${cart.sum} €"),
            ),
          )),
      body: Center(
        child: Consumer<Cart>(
          builder: (context, cart, child) => ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    '${cart.items[index].name} (${cart.items[index].price}€)'),
              );
            },
          ),
        ),
      ),
    );
  }
}
