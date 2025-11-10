
import 'package:flutter/material.dart';
import 'package:foo_form_field/src/core/mappers/base/field_value_mapper.dart';
///[I] is The type which the form field accepts
///[O] is The type which the client wants to get or set
abstract class FooFieldController<O,I> extends ChangeNotifier {
  
  final O? initialValue;

  I? get initialValueAsFieldValue => mapper.toFieldType(initialValue);
  
  bool _enabled;

  final bool Function(O x, O y) areEqual; 

  final FieldValueMapper<O,I> mapper;

  FormFieldState<I>? _formFieldState;

  String? _forcedErrorText;

  bool _isValueChanged;

  bool get isValueChanged => _isValueChanged;

  FooFieldController({
    required this.areEqual,
    required bool? enabled,
    required String? forcedErrorText,
    required this.initialValue,
    required this.mapper,
  }): _enabled = enabled?? true, _forcedErrorText = forcedErrorText, _isValueChanged = false;

  void setFormFieldState(FormFieldState<I> formFieldState){
    _formFieldState = formFieldState;
    value = initialValue;
    notifyListeners();
  }

  bool _getIsValueChanged(O? x, O? y){
    if (x == null && y == null) {
      return false;
    }
    else if (x == null && y != null) {
      return true;
    }
    else if (x != null && y == null) {
      return true;
    }
    else if (!areEqual(x!, y!)) {
      return true;
    }

    return false;
  }

  bool get enabled => _enabled;

  set enabled(bool value) {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<I> formFieldState) {
        _enabled = value;
      },
    );
  }

  O? get value{
    if (_formFieldState == null) {
      return initialValue;
    }
    return mapper.toClientType(_formFieldState!.value);
  }

  set value(O? newValue){
    return excute<void>(
      needToNotifyListener: true,
      isValueChanged: _getIsValueChanged(value, newValue),
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.didChange(mapper.toFieldType(newValue));
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

  void clear()=> value = null;

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
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<I> formFieldState) {
        _forcedErrorText = value;
      },
    );
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
    bool needToNotifyListener = false,
    bool isValueChanged = false,
    required R Function(FormFieldState<I> formFieldState) toExecute,
  }) {
    _ensureStateExistence();
    R result = toExecute(_formFieldState!);
    _isValueChanged = isValueChanged;
    if (needToNotifyListener) {
      notifyListeners();
    }
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