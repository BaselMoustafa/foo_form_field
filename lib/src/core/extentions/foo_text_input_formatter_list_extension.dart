import 'package:foo_form_field/src/core/formatters/foo_text_input_formatter.dart';

extension FooTextInputFormatterListExtension on List<FooTextInputFormatter> {

  String? validate(String value) {
    for (var formatter in this) {
      String? validationResult = formatter.validate(value);
      if (validationResult != null) {
        return validationResult;
      }
    }
    return null;
  }

  String? canWrite(String value) {
    for (var formatter in this) {
      String? canWriteResult = formatter.canWrite(value);
      if (canWriteResult != null) {
        return canWriteResult;
      }
    }
    return null;
  }
}