import 'package:flutter/material.dart';
import '../../../foo_form_field.dart';

class IntTextFormField extends StatelessWidget {
  const IntTextFormField({
    super.key, 
    required this.controller,
    this.properties,
    this.formatter,
    this.stateProvider,
  });

  final IntTextEditingController controller;
  final TextFormFieldProperties<int>? properties;
  final IntTextFormatter? formatter;
  final FooFormFieldStateProvider<String>? stateProvider;

  IntTextFormatter get _formatter => formatter ?? IntTextFormatter();

  @override
  Widget build(BuildContext context) {
    return FooTextFormField(
      stateProvider: stateProvider,
      controller: controller,
      properties: properties,
      fooTextFormatters: [
        _formatter,
      ],
      keyboardType: TextInputType.numberWithOptions(
        signed: _formatter.allowNegative,
        decimal: false,
      ),
    );
  }
}