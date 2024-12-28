import 'package:flutter/material.dart';
import 'package:madcamp_w1/screens/color_change.dart';
import 'package:madcamp_w1/screens/home_screen.dart';
import 'package:madcamp_w1/screens/color_change.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mad Camp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
