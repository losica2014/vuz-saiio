import 'package:flutter/material.dart';

import 'lab1/page.dart';
import 'lab2/page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'САиИО',
      theme: ThemeData(
        
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HabitatPage(),
        '/lab2': (context) => const PumpStationPage(),
      },
    );
  }
}
