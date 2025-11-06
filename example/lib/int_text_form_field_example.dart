import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class IntTextFormFieldExample extends StatefulWidget {
  const IntTextFormFieldExample({super.key});

  @override
  State<IntTextFormFieldExample> createState() => _IntTextFormFieldExampleState();
}

class _IntTextFormFieldExampleState extends State<IntTextFormFieldExample> {
  final StringTextEditingController _controller = StringTextEditingController();
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
              IntTextFormField(
                controller: _controller,
                formatter: IntegerTextInputFormatter(
                  maxLength: 10,
                  allowNegative: true
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
                  _controller.value = "true";
                },
                child: Text('Mark As True')
              ),
          
              TextButton(
                onPressed: () {
                  _controller.value = "false";
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