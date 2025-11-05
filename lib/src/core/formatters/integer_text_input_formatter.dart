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

  int? _effectiveMaxLength(String value) {
    if (maxLength==null) {
      return null;
    }

    if (! allowNegative) {
      return maxLength!;
    }

    if (value.isNotEmpty && value[0]=='-') {
      return maxLength!+1;
    }

    return maxLength!;
  }

  @override
  String? canWrite(String value) {
    if (value.trim().length != value.length) {
      return containsNonIntegerMessage;
    }

    if(_effectiveMaxLength(value)!=null && value.length > _effectiveMaxLength(value)!){
      return exceedMaxLengthMessage;
    }

    for (var i = 0; i < value.length; i++) {
      if (i==0 && value[i]=='-') {
        if(!allowNegative) {
          return invalidNegativeMessage;
        }
        
        continue ;
      }

      if (int.tryParse(value[i])==null) {
        return containsNonIntegerMessage;
      }
    }
    return null;
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