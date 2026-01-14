
import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';


class FooFieldController<Value, FieldValue> extends ChangeNotifier {

  bool _enabled;

  Value? _value;

  final Mapper<Value, FieldValue> mapper;

  final Value? initialValue;
  
  final bool Function(Value x, Value y) areEqual;

  FooFieldController({
    this.initialValue,
    required bool? enabled,
    required this.mapper,
    required this.areEqual,
  }) : _enabled = enabled ?? true,
       _value = initialValue;

  FieldValue? get fieldValue => mapper.toFieldValue(_value);

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  Value? get value => _value;

  set value(Value? newValue) {
    _value = newValue;
    notifyListeners();
  }

  void clear() => value = null;

  void reset() => value = initialValue;
}
