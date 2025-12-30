import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';
import '../../controllers/foo_text_editing_controllers/int_text_editing_controller.dart';

class IntTextFormField extends StatelessWidget {
  const IntTextFormField({
    super.key, 
    required this.controller,
    this.properties,
    this.formatter,
  });

  final IntTextEditingController controller;
  final TextFormFieldProperties<int>? properties;
  final IntTextFormatter? formatter;
  

  IntTextFormatter get _formatter => formatter ?? IntTextFormatter();

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
        decimal: false,
      ),
    );
  }
}