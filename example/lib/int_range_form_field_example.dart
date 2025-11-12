import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntRangeValueFormFieldExample extends StatefulWidget {
  const IntRangeValueFormFieldExample({super.key});

  @override
  State<IntRangeValueFormFieldExample> createState() => _IntRangeValueFormFieldExampleState();
}

class _IntRangeValueFormFieldExampleState extends State<IntRangeValueFormFieldExample> {
  final  _controller = IntStringRangeFieldController(
    initialValue: IntRange(min: 0, max: 100),
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
              IntStringRangeFormField(
                rangeValidator: IntRangeValidator(),
                controller: _controller,
                validator: (value) {
                  if (value == null || value.min == null || value.max == null) {
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
                  _controller.value = IntRange(min: 100, max: 300);
                },
                child: Text('Mark As 100 300')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.value =IntRange(min: -100, max: 100);
                },
                child: Text('Mark As -100 100')
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
