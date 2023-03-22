import 'package:flutter/material.dart';
import 'package:marchand/fruit.dart';
import 'fruit_preview.dart';
import 'screens/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'cart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Fruit>> fetchFruits() async {
    var url = Uri.https('fruits.shrp.dev', 'items/fruits');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Fruit.fromJsonList(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load fruits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          ],
          title: Center(
            child: Consumer<Cart>(
              builder: (context, cart, child) =>
                  Text("${widget.title} ${cart.sum} €"),
            ),
          )),
      body: Center(
        child: FutureBuilder<List<Fruit>>(
          future: fetchFruits(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return FruitWidget(
                      fruit: snapshot.data![index],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
