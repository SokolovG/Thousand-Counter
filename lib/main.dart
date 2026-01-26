import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_counter/presentation/screens/home.dart';

void main() {
  runApp(const ProviderScope(child: ThousandCounterApp()));
}

class ThousandCounterApp extends StatelessWidget {
  const ThousandCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thousand Counter',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepOrange)),
      home: const HomeScreen(title: 'Thousand Counter'),
    );
  }
}
