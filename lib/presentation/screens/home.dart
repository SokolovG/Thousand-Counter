import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thousand Counter"),
        backgroundColor: const Color.fromARGB(255, 201, 12, 12),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50), // Отступ сверху
          Text('Немного ниже AppBar'),
        ],
      ),
    );
  }
}
