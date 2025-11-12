part of '../exporter.dart';
class IntStringFormField extends FooStringFormField<int> {
  
  IntStringFormField({
    super.key,
    required super.controller,
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