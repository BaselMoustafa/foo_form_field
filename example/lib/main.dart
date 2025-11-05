import 'package:flutter/material.dart';
import 'package:example/test_screen.dart';  
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const TestScreen(),
      theme: ThemeData(
        disabledColor: Colors.brown,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent,primary: Colors.blueAccent,secondary:  Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 24
          ),
        )
      ),
    );
  }
}