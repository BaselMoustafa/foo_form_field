import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/controllers/implementations/string_field_controller.dart';
import 'package:foo_form_field/src/core/models/text_from_field_properties.dart';

class StringFormField extends FooStringFormField<String> {
  
  const StringFormField({
    super.key,
    required StringFieldController super.controller,
    super.properties,
    super.fooInputFormatters,
    super.keyboardType
  });

  StringFormField.integer({
    Key?key,
    required StringFieldController controller,
    TextFormFieldProperties<String>? properties,
    IntegerTextInputFormatter? formatter,
  }):this(
    key: key,
    controller: controller,
    properties: properties,
    fooInputFormatters: [
      formatter ?? IntegerValueInputFormatter(),
    ],
    keyboardType: TextInputType.numberWithOptions(
      signed: (formatter ?? IntegerTextInputFormatter()).allowNegative,
      decimal: false,
    ),
  );

}