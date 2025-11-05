import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class FooRangeFieldController<T> extends BaseFooFieldController<T> {

  late final FormFieldState<T> _minFormFieldState;
  late final FormFieldState<T> _maxFormFieldState;

  void setFormFieldStates({
    required FormFieldState<T> minFormFieldState,
    required FormFieldState<T> maxFormFieldState,
  }){
    _minFormFieldState = minFormFieldState;
    _maxFormFieldState = maxFormFieldState;
  }

  @override
  void clear() {
    _minFormFieldState.didChange(null);
    _maxFormFieldState.didChange(null);
    notifyListeners();
  }
  
  @override
  void save() {
    _minFormFieldState.save();
    _maxFormFieldState.save();
    notifyListeners();
  }
  
  @override
  bool validate() {
    bool isValidMin = _minFormFieldState.validate();
    bool isValidMax = _maxFormFieldState.validate();
    return isValidMin && isValidMax;
  }

  T? get minValue => _minFormFieldState.value;

  T? get maxValue => _maxFormFieldState.value;

  set minValue(T? value) {
    _minFormFieldState.didChange(value);
    notifyListeners();
  }

  set maxValue(T? value) {
    _maxFormFieldState.didChange(value);
    notifyListeners();
  }

}