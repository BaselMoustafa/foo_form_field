import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';

class NumTextFormField extends StatelessWidget {
  const NumTextFormField({
    super.key, 
    required this.controller,
    this.properties,
    this.formatter,
  });

  final NumTextEditingController controller;
  final TextFormFieldProperties<num>? properties;
  final NumTextFormatter? formatter;
  

  NumTextFormatter get _formatter => formatter ?? NumTextFormatter();

  @override
  Widget build(BuildContext context) {
    return FooTextFormField(
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
