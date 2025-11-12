import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class DateFormFieldExample extends StatefulWidget {
  const DateFormFieldExample({super.key});

  @override
  State<DateFormFieldExample> createState() => _DateFormFieldExampleState();
}

class _DateFormFieldExampleState extends State<DateFormFieldExample> {
  final  _controller = DateFieldController(
    initialValue: DateTime(2024, 1, 1),
    enabled: false,
  );
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
          child: ListView(
            children: [
              StringFormField(controller: StringFieldController(),properties: TextFormFieldProperties(
                textInputAction: TextInputAction.next,
              ),),
              DateFormField(
                decoration: InputDecoration(
                  hintText: "Select a date",
                  hintStyle: TextStyle(color: Colors.brown),
                ),
                controller: _controller,
                validator: (value) {
                  if (value == null ) {
                    return 'This field is required This f  ';
                  }
                  return null;
                },
                onSaved: (value) {
                  log("onSaved: $value");
                },
                onChanged: (value) {
                  log("onChanged: $value");
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
                  _controller.value = DateTime(2025, 5, 5);
                },
                child: Text('Mark As 2025-5-5')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.value =DateTime(2025, 11, 11);
                },
                child: Text('Mark As 2025-11-11')
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

              TextButton(
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                child: Text('Validate Form')
              )
          
            ],
          ),
        ),
      ),
    );

    
  }
}
