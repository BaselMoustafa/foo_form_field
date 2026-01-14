
import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';


class FooFieldController<Value, FieldValue> extends ChangeNotifier {

  Value? _value;

  final Mapper<Value, FieldValue> mapper;

  final Value? initialValue;
  
  final bool Function(Value x, Value y) areEqual;

  FooFieldController({
    this.initialValue,
    required this.mapper,
    required this.areEqual,
  }) :  _value = initialValue;

  FieldValue? get fieldValue => mapper.toFieldValue(_value);

  Value? get value => _value;

  set value(Value? newValue) {
    _value = newValue;
    notifyListeners();
  }

  void clear() => value = null;

  void reset() => value = initialValue;
}
