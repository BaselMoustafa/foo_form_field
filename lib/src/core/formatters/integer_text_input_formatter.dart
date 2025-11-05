import 'package:foo_form_field/src/core/extentions/string_extension.dart';
import 'package:foo_form_field/src/core/formatters/foo_text_input_formatter.dart';

class IntegerTextInputFormatter extends FooTextInputFormatter {

  late final int? maxLength;
  final bool allowNegative;

  final String exceedMaxLengthMessage;
  final String invalidNegativeMessage;
  final String containsNonIntegerMessage;

  IntegerTextInputFormatter({
    this.maxLength,
    this.allowNegative = false,
    this.exceedMaxLengthMessage = "Exceed max length",
    this.invalidNegativeMessage = "Invalid negative number",
    this.containsNonIntegerMessage = "Must be an integer",
  }){
    if(maxLength!=null && maxLength! < 1){
      throw ArgumentError.value(maxLength, 'maxLength', 'Max length must be greater than 0');
    }
  }

  

  @override
  String? canWrite(String value) {
    return value.canBeIntText(
      allowNegative: allowNegative,
      maxLength: maxLength,
      invalidNegativeMessage: invalidNegativeMessage,
      containsNonIntegerMessage: containsNonIntegerMessage,
      exceedMaxLengthMessage: exceedMaxLengthMessage,
    );
  }

  @override
  String? validate(String value) {
    final canWriteResult = canWrite(value);
    if (canWriteResult != null) {
      return canWriteResult;
    }

    if (value=="-") {
      return invalidNegativeMessage;
    }

    return null;
  }

  
}