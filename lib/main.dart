import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TruequeUApp());
}

class TruequeUApp extends StatelessWidget {
  const TruequeUApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruequeU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}