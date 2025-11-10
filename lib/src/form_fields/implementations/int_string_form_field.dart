import 'package:flutter/services.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/controllers/implementations/int_string_field_controller.dart';

class IntStringFormField extends FooStringFormField<int> {
  
  IntStringFormField({
    super.key,
    required IntStringFieldController super.controller,
    IntegerValueInputFormatter? formatter,
    super.properties,
  }):super(
    fooInputFormatters: [
      formatter ?? IntegerValueInputFormatter(),
    ],
    keyboardType: TextInputType.numberWithOptions(
      signed: (formatter?? IntegerValueInputFormatter()).allowNegative,
      decimal: false,
    ),
  );
}