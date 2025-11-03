import 'package:flutter/services.dart';
import 'package:flutter_form_fields/src/core/formatters/flutter_text_input_formatter.dart';

class IntegerTextInputFormatter extends FlutterTextInputFormatter {

  final int maxLength;
  final bool allowNegative;
  final String exceedMaxLengthMessage;
  final String invalidNegativeMessage;

  const IntegerTextInputFormatter({
    this.maxLength=20,
    this.allowNegative = false,
    this.exceedMaxLengthMessage = "Exceed max length",
    this.invalidNegativeMessage = "Invalid negative number",
  });

  @override
  String? matches(String value) {

    if(maxLength < 1){
      throw ArgumentError.value(maxLength, 'maxLength', 'Max length must be greater than 0');
    }

    if(value.length > maxLength){
      return exceedMaxLengthMessage;
    }
    if(value.split("-").length > (allowNegative ? 2 : 1)){
      return invalidNegativeMessage;
    }
    return null;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(matches(newValue.text) != null){
      return oldValue;
    }
    return newValue;
  }
}