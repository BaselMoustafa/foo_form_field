
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

    bool shouldNotify(){
      if (_value == null && newValue == null) {
        return false;
      }
      if (_value == null && newValue != null) {
        return true;
      }
      if (_value != null && newValue == null) {
        return true;
      }
      return ! areEqual(
        _value as Value, 
        newValue as Value,
      );
    }

    _value = newValue;
    
    if (shouldNotify()) {
      notifyListeners();
    }
  }

  void clear() => value = null;

  void reset() => value = initialValue;
}
