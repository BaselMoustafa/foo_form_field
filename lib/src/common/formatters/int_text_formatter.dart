import '../string_validators.dart';
import 'foo_text_formatter.dart';

class IntTextFormatter extends FooTextFormatter<IntTextFormatterErrorMessages>{

  final int? maxValue;
  final bool allowNegative;
  
  IntTextFormatter({
    IntTextFormatterErrorMessages? messages,
    this.allowNegative = false,
    this.maxValue,
  }):super(
    messages: messages ?? IntTextFormatterErrorMessages(),
  );

  @override
  List<String> get notValidButCanBeWrittenValues => [
    if (allowNegative) "-",
  ];

  @override
  String? validate(String value) {
    bool isValidInt = StringValidators.isInteger(
      value: value, 
    );

    if (! isValidInt) {
      return messages.invalidValueMessage;
    }

    int? parsedValue = int.tryParse(value);

    if (parsedValue == null) {
      return messages.invalidValueMessage;
    }

    if (maxValue != null && parsedValue > maxValue!) {
      return messages.greaterThanMaxValueMessage;
    } 

    return null;
  }
}

class IntTextFormatterErrorMessages extends FooTextFormatterErrorMessages {
  
  final String greaterThanMaxValueMessage;
  final String invalidNegativeMessage;

  IntTextFormatterErrorMessages({
    this.greaterThanMaxValueMessage = "Greater than max value",
    this.invalidNegativeMessage = "Invalid negative number",
    super.invalidValueMessage = "Invalid",
  });
}