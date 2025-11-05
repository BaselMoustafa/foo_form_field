
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  final FooFieldController<bool> _controller = FooFieldController<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Column(
        children: [
          
          BooleanFormField(
            controller: _controller,
            onChanged: (value) {
              log("Finally At The End: $value");
              setState(() {
                
              });
            },
          ),
          TextButton(
            onPressed: () {
              _controller.clear();
            }, 
            child: Text('Clear')
          ),

          TextButton(
            onPressed: () {
              _controller.validate();
            },
            child: Text('Validate')
          ),

          TextButton(
            onPressed: () {
              _controller.value = true;
            },
            child: Text('Mark As True')
          ),

          TextButton(
            onPressed: () {
              _controller.value = false;
            },
            child: Text('Mark As False')
          ),

        ],
      ),
    );
  }
}