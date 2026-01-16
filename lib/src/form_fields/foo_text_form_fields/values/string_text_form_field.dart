import 'package:flutter/material.dart';

import '../../../../foo_form_field.dart';

class StringTextFormField extends StatelessWidget {
  const StringTextFormField({
    super.key, 
    required this.controller, 
    this.properties, 
    this.formatter, 
    this.keyboardType,
    this.stateProvider,
  });

  final StringTextEditingController controller;
  final TextFormFieldProperties<String>? properties;
  final StringTextFormatter? formatter;
  final TextInputType? keyboardType;
  final FooFormFieldStateProvider<String>? stateProvider;

  factory StringTextFormField.integer({
    required StringTextEditingController controller,
    int? maxLength,
    StringTextFormatterErrorMessages? messages,
    TextFormFieldProperties<String>? properties,
  }) {
    return StringTextFormField(
      controller: controller,
      properties: properties,
      keyboardType:TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      formatter: StringTextFormatter(
        maxLength: maxLength, 
        regExpression: RegExp( r'^\d+$'),  
        messages: messages
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FooTextFormField(
      stateProvider: stateProvider,
      controller: controller,
      keyboardType: keyboardType,
      properties: properties,
      fooTextFormatters: [
        formatter ?? const StringTextFormatter(),
      ],
    );
  }
}