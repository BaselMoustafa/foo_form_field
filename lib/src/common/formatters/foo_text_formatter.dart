
import 'package:flutter/services.dart';
abstract class FooTextFormatterErrorMessages {
  final String invalidValueMessage;

  const FooTextFormatterErrorMessages({
    required this.invalidValueMessage,
  });
}


abstract class FooTextFormatter<Messages extends FooTextFormatterErrorMessages> extends TextInputFormatter {
  
  final Messages messages;
  
  const FooTextFormatter({
    required this.messages,
  });

  List<String> get notValidButCanBeWrittenValues;

  String? validate(String value);

  String? _canWrite(String value){
    if(value.isEmpty){
      return null;
    }
    if (notValidButCanBeWrittenValues.contains(value)) {
      return null;
    }
    return validate(value);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {

    if (_canWrite(newValue.text) == null) {
      return newValue;
    }

    if (_canWrite(oldValue.text) != null) {
      return newValue;
    }

    return oldValue;
  }
}
