import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntValueFormFieldExample extends StatefulWidget {
  const IntValueFormFieldExample({super.key});

  @override
  State<IntValueFormFieldExample> createState() => _IntValueFormFieldExampleState();
}

class _IntValueFormFieldExampleState extends State<IntValueFormFieldExample> {
  final ValueFieldController<int> _controller = ValueFieldController<int>(
    initialValue: 123,
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
              IntValueFormField(
                controller: _controller,
                formatter: IntegerValueInputFormatter(
                  allowNegative: true,
                ),
                validator: (value) {
                  if (value == null) {
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
                  _controller.value = 1;
                },
                child: Text('Mark As True')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.value = 0;
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