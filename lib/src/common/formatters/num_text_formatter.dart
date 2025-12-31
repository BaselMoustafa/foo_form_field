import '../string_validators.dart';
import 'foo_text_formatter.dart';

class NumTextFormatter extends FooTextFormatter<NumTextFormatterErrorMessages>{

  final num? maxValue;
  final bool allowNegative;
  
  NumTextFormatter({
    NumTextFormatterErrorMessages? messages,
    this.allowNegative = false,
    this.maxValue,
  }):super(
    messages: messages ?? NumTextFormatterErrorMessages(),
  );

  @override
  List<String> get notValidButCanBeWrittenValues => [
    ".",
    if (allowNegative) "-.",
    if(allowNegative) "-",
  ];

  @override
  String? validate(String value) {
    bool isValidNum = StringValidators.isNumber(
      value: value, 
    );

    if (! isValidNum) {
      return messages.invalidValueMessage;
    }

    num? parsedValue = num.tryParse(value);

    if (parsedValue == null) {
      return messages.invalidValueMessage;
    }

    if (maxValue != null && parsedValue > maxValue!) {
      return messages.greaterThanMaxValueMessage;
    } 

    return null;
  }
}

class NumTextFormatterErrorMessages extends FooTextFormatterErrorMessages {
  
  final String greaterThanMaxValueMessage;
  final String invalidNegativeMessage;

  NumTextFormatterErrorMessages({
    this.greaterThanMaxValueMessage = "Greater than max value",
    this.invalidNegativeMessage = "Invalid negative number",
    super.invalidValueMessage = "Invalid",
  });
}
