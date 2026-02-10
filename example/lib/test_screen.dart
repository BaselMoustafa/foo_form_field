import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  final _controller= StringTextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      log("Listener ====> Text = ${_controller.value}");
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 25,
          children:[
            StringTextFormField(
              controller: _controller,
            )
          ],
        ),
      ),
    );
  }
}