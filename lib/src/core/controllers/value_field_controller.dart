import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';

class ConvertableValueFieldController<O, I> extends FooFieldController<O,I> {

  ConvertableValueFieldController({
    super.initialValue,
    super.enabled,
    required super.fromFieldValue,
    required super.toFieldValue,
    
  });


  FormFieldState<I>? _formFieldState;

  void setFormFieldState(FormFieldState<I> formFieldState){
    _formFieldState = formFieldState;
    value = initialValue;
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

  @override
  O? get value{
    if (_formFieldState == null) {
      return initialValue;
    }
    return fromFieldValue(_formFieldState!.value);
  }

  @override
  set value(O? value) {
    return _excuteAfterCheckStateExistence<void>(
      toExecute: (formFieldState) {
        formFieldState.didChange(toFieldValue(value));
        notifyListeners();
      },
    );
  }

  R _excuteAfterCheckStateExistence<R>({
    required R Function(FormFieldState<I> formFieldState) toExecute,
  }) {
    if (_formFieldState == null) {
      throw Exception(
        "This Controller is not attached to a any Foo Form Field",
      );
    }
    return toExecute(_formFieldState!);
  }
  
}

class ValueFieldController<T> extends ConvertableValueFieldController<T,T> {

  ValueFieldController({
    super.initialValue,
    super.enabled,
  }): super(
    fromFieldValue: (i) => i,
    toFieldValue: (o) => o,
  );
}