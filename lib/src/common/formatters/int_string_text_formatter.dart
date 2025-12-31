
import '../string_validators.dart';
import 'foo_text_formatter.dart';

class IntegerValueInputFormatter extends FooTextFormatter<IntegerStringTextFormatterErrorMessages> {
  
  final bool allowNegative;
  final int? maxDigits;

  const IntegerValueInputFormatter({
    IntegerStringTextFormatterErrorMessages? messages,
    this.allowNegative = false,
    this.maxDigits,
  }):super(
    messages: messages ?? const IntegerStringTextFormatterErrorMessages(),
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

    if(value[0]=="-" && !allowNegative) {
      return messages.invalidNegativeMessage;
    }

    if (maxDigits != null && value.length > maxDigits!) {
      return messages.greaterThanMaxDigitsMessage;
    }

    return null;
  }
}

class IntegerStringTextFormatterErrorMessages extends FooTextFormatterErrorMessages {
  final String invalidNegativeMessage;
  final String greaterThanMaxDigitsMessage;

  const IntegerStringTextFormatterErrorMessages({
    super.invalidValueMessage = "Invalid",
    this.invalidNegativeMessage = "Invalid negative number",
    this.greaterThanMaxDigitsMessage = "Greater than max digits",
  });
}
