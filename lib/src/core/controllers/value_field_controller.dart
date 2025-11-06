import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class ValueFieldController<T> extends FooFieldController<T> {
  
  ValueFieldController({
    T? initialValue,
    super.enabled = true,
  }): _initialValue = initialValue;

  final T? _initialValue;

  FormFieldState<T>? _formFieldState;

  void setFormFieldState(FormFieldState<T> formFieldState){
    _formFieldState = formFieldState;
    value = _initialValue;
    notifyListeners();
  }
  
  @override
  void clear() {
    return _excuteAfterCheckStateExistence<void>(
      toExecute: (formFieldState) {
        formFieldState.didChange(null);
        notifyListeners();
      },
    );
  }
  
  @override
  void save() {
    return _excuteAfterCheckStateExistence<void>(
      toExecute: (formFieldState) {
        formFieldState.save();
        notifyListeners();
      },
    );
  }
  
  @override
  bool validate() {
    return _excuteAfterCheckStateExistence<bool>(
      toExecute: (formFieldState) {
        return formFieldState.validate();
      },
    );
  }

  T? get value => _formFieldState==null? _initialValue: _formFieldState!.value;

  set value(T? value) {
    return _excuteAfterCheckStateExistence<void>(
      toExecute: (formFieldState) {
        formFieldState.didChange(value);
        notifyListeners();
      },
    );
  }

  R _excuteAfterCheckStateExistence<R>({
    required R Function(FormFieldState<T> formFieldState) toExecute,
  }) {
    if (_formFieldState == null) {
      throw Exception(
        "This Controller is not attached to a any Foo Form Field",
      );
    }
    return toExecute(_formFieldState!);
  }
  
}