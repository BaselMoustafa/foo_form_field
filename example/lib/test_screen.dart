
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              
              BooleanFormField(
                controller: _controller,
                yesText: 'Antch YesAntch YesAnt',
                noText: 'Antch No',
                validator: (value) {
                  log("On Validated =====> $value");
                  if (value == null) {
                    return 'This field is required This f  ';
                  }
                  return null;
                },
                onSaved: (value) {
                  log("On Saved Of Field =====> $value");
                },
                onChanged: (value) {
                  log("On Changed =====> $value");
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
          
              TextButton(
                onPressed: () {
                  _controller.enabled = false;
                },
                child: Text('Disable')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.enabled = true;
                },
                child: Text('Enable')
              ),
          
              TextButton(
                onPressed: () {
                  _formKey.currentState?.save();
                },
                child: Text('Svae From Form')
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}