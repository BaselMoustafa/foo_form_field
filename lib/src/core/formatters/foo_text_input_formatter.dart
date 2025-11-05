import 'package:flutter/services.dart';

abstract class FooTextInputFormatter extends TextInputFormatter {

  const FooTextInputFormatter();

  String? validate(String value);

  String? canWrite(String value);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (canWrite(newValue.text) == null) {
      return newValue;
    }

    if (canWrite(oldValue.text) == null) {
      return oldValue;
    }

    return TextEditingValue();
  }
}