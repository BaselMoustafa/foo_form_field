part of '../exporter.dart';

class StringFormField extends FooStringFormField<String> {
  
  const StringFormField({
    super.key,
    required super.controller,
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