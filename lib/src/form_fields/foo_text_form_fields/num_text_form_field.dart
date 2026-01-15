import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';
import '../../common/formatters/numeric_text_formatter.dart';

class NumTextFormField extends StatelessWidget {
  const NumTextFormField({
    super.key, 
    required this.controller,
    this.properties,
    this.formatter,
    this.stateProvider,
  });

  final NumTextEditingController controller;
  final TextFormFieldProperties<num>? properties;
  final NumTextFormatter? formatter;
  final FooFormFieldStateProvider<String>? stateProvider;
  

  NumTextFormatter get _formatter => formatter ?? NumTextFormatter();

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
        decimal: true,
      ),
    );
  }
}
