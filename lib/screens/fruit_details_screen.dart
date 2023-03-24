import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:marchand/fruit.dart';
import '../provider/cart.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: fruit.image,
              ),
              Column(
                children: [
                  const SizedBox(height: 75),
                  Text(fruit.name),
                  const SizedBox(height: 75),
                  Text('${fruit.price.toString()}€'),
                  const SizedBox(height: 75),
                ],
              ),
              TextButton(
                  style: const ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).remove(fruit);
                  },
                  child: const Text('Supprimer du panier')),
            ],
          ),
          Expanded(
              child: FlutterMap(
            options: MapOptions(
              center: LatLng(fruit.origin['location']['coordinates'][1],
                  fruit.origin['location']['coordinates'][0]),
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                maxZoom: 20,
                subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(fruit.origin['location']['coordinates'][1],
                        fruit.origin['location']['coordinates'][0]),
                    width: 80,
                    height: 80,
                    builder: (context) => const Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          )),
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
