
import 'package:flutter/material.dart';
///[I] is The type which the form field accepts
///[O] is The type which the client wants to get or set
class FooFieldController<O,I> extends ChangeNotifier {
  
  final O? initialValue;

  I? get initialValueAsFieldValue => toFieldValue(initialValue);
  
  bool _enabled;

  final O? Function(I? i) fromFieldValue;

  final I? Function(O? o) toFieldValue;

  FormFieldState<I>? _formFieldState;

  String? _forcedErrorText;

  FooFieldController({
    required bool? enabled,
    required String? forcedErrorText,
    required this.initialValue,
    required this.fromFieldValue,
    required this.toFieldValue,
  }): _enabled = enabled?? true, _forcedErrorText = forcedErrorText;

  void setFormFieldState(FormFieldState<I> formFieldState){
    _formFieldState = formFieldState;
    value = initialValue;
    notifyListeners();
  }

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    notifyListeners();
  }

  O? get value{
    if (_formFieldState == null) {
      return initialValue;
    }
    return fromFieldValue(_formFieldState!.value);
  }

  set value(O? newValue){
    return excute<void>(
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.didChange(toFieldValue(newValue));
      },
    );
  }

  bool validate(){
    return excute<bool>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.validate();
      },
    );
  }

  void clear(){
    return excute<void>(
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.didChange(null);
      },
    );
  }

  void save(){
    return excute<void>(
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.save();
      },
    );
  }

  String? get forcedErrorText{
    return _forcedErrorText;
  }

  set forcedErrorText(String? value){
    _forcedErrorText = value;
    notifyListeners();
  }

  String? get errorText{
    if (_formFieldState == null) {
      return null;
    }
    return _formFieldState!.errorText;
  }

  bool get hasError{
    return excute<bool>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.hasError;
      },
    );
  }

  bool get isValid{
    return excute<bool>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.isValid;
      },
    );
  }

  @protected
  R excute<R>({
    required R Function(FormFieldState<I> formFieldState) toExecute,
  }) {
    _ensureStateExistence();
    R result = toExecute(_formFieldState!);
    notifyListeners();
    return result;
  }

  void _ensureStateExistence(){
    if (_formFieldState == null) {
      throw Exception(
        "This Controller is not attached to a any Foo Form Field",
      );
    }
  }
}