import 'package:flutter/material.dart';
import 'package:marchand/fruit.dart';
import '../widget/fruit_preview.dart';
import 'cart_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

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
  List<Fruit> ete = [];
  List<Fruit> hiver = [];
  List<Fruit> automne = [];
  List<Fruit> printemps = [];
  List<Fruit> allFruits = [];
  List<String> saison = ['Tout', 'Printemps', 'Eté', 'Automne', 'Hiver'];

  Future<List<Fruit>> getFruits(String saison) async {
    List<Fruit> listFruit = [];
    var url = Uri.parse('https://fruits.shrp.dev/items/fruits?fields=*.*');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      listFruit.addAll(Fruit.fromJsonList(jsonDecode(response.body)['data']));
      if (saison == 'Tout') {
        return listFruit;
      } else if (saison == 'Eté') {
        ete.clear();
        for (Fruit fruit in listFruit) {
          if (fruit.season == 'Eté') {
            ete.add(fruit);
          }
        }
        return ete;
      } else if (saison == 'Printemps') {
        printemps.clear();
        for (Fruit fruit in listFruit) {
          if (fruit.season == 'Printemps') {
            printemps.add(fruit);
          }
        }
        return printemps;
      } else if (saison == 'Hiver') {
        hiver.clear();
        for (Fruit fruit in listFruit) {
          if (fruit.season == 'Hiver') {
            hiver.add(fruit);
          }
        }
        return hiver;
      } else if (saison == 'Automne') {
        automne.clear();
        for (Fruit fruit in listFruit) {
          if (fruit.season == 'Automne') {
            automne.add(fruit);
          }
        }
        return automne;
      }
    }
    return listFruit;
  }

  late String dropdownValue = saison.first;

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
          child: Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: saison.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: FutureBuilder<List<Fruit>>(
              future: getFruits(dropdownValue),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return FruitPreview(
                          fruit: snapshot.data![index],
                        );
                      });
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
