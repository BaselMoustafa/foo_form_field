import 'package:flutter/material.dart';
import 'test_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: TestScreen(), 
      theme: ThemeData(
        disabledColor: Colors.brown,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent,primary: Colors.blueAccent,secondary:  Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
            gapPadding: 2
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            gapPadding: 2
          ),
           
          errorStyle: TextStyle(
            color: Colors.red,
          ),
        )
      ),
    );
  }
}