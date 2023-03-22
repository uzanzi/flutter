import 'package:flutter/material.dart';
import 'package:marchand/cart.dart';
import 'package:provider/provider.dart';
import 'fruits_master.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Cart(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marchand',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: 'Total panier : ',
        ));
  }
}
