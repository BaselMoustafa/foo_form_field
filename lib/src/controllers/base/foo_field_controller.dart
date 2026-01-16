
import 'package:flutter/material.dart';

class FooFieldController<Value> extends ChangeNotifier {

  Value? _value;

  final Value? initialValue;
  
  final bool Function(Value x, Value y) areEqual;

  FooFieldController({
    this.initialValue,
    required this.areEqual,
  }) :  _value = initialValue;


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

    bool shouldNotifyListeners = shouldNotify();

    _value = newValue;
    
    if (shouldNotifyListeners) {
      notifyListeners();
    }
  }

  void clear() => value = null;

  void reset() => value = initialValue;
}
