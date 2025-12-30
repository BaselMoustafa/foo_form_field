import 'dart:core';

abstract class StringValidators {
  
  static bool isInteger({
    required String value,
  })=>_validate(
    value: value, 
    regExp: RegExp(r'^-?\d+$'),
  );

  static bool _validate({
    required String value,
    required RegExp regExp,
  })=> regExp.hasMatch(value);
}