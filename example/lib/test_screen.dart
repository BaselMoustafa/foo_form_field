
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Column(
        children: [
          
          BooleanFormField(
            onChanged: (value) {
              log("Finally At The End: $value");
              setState(() {
                
              });
            },
          ),
          TextButton(onPressed: () {
          }, child: Text('Submit')),
        ],
      ),
    );
  }
}