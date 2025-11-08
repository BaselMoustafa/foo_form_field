import 'package:flutter/material.dart';
///[I] is The type which the form field accepts
///[O] is The type which the client wants to get or set
abstract class FooFieldController<O,I> extends ChangeNotifier {
  
  final O? initialValue;

  I? get initialValueAsFieldValue => _toFieldValue(initialValue);
  
  bool _enabled;

  final O? Function(I? i) _fromFieldValue;

  final I? Function(O? o) _toFieldValue;

  FormFieldState<I>? _formFieldState;

  String? _forcedErrorText;

  FooFieldController({
    required bool? enabled,
    required String? forcedErrorText,
    required this.initialValue,
    required O? Function(I? i) fromFieldValue,
    required I? Function(O? o) toFieldValue,
  }): _enabled = enabled?? true, _forcedErrorText = forcedErrorText, _fromFieldValue = fromFieldValue, _toFieldValue = toFieldValue;

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
    return _fromFieldValue(_formFieldState!.value);
  }

  set value(O? value){
    return excute<void>(
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.didChange(_toFieldValue(value));
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
    return excute<String?>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.errorText;
      },
    );
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