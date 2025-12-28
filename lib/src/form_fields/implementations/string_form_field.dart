// part of '../exporter.dart';

// /// Text form field wired to a `StringFieldController` with optional formatters.
// class StringFormField extends FooStringFormField<String> {
//   const StringFormField({
//     super.key,
//     required super.controller,
//     super.properties,
//     super.fooInputFormatters,
//     super.keyboardType,
//   });

//   /// Convenience constructor configured for integer-only input.
//   StringFormField.integer({
//     Key? key,
//     required StringFieldController controller,
//     TextFormFieldProperties<String>? properties,
//     IntegerTextInputFormatter? formatter,
//   }) : this(
//          key: key,
//          controller: controller,
//          properties: properties,
//          fooInputFormatters: [formatter ?? IntegerValueInputFormatter()],
//          keyboardType: TextInputType.numberWithOptions(
//            signed: (formatter ?? IntegerTextInputFormatter()).allowNegative,
//            decimal: false,
//          ),
//        );
// }
