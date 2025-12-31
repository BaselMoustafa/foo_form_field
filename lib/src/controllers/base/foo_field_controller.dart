
import 'package:flutter/material.dart';

import '../../../foo_form_field.dart';


class FooFieldController<Value, FieldValue> extends ChangeNotifier {
  final Value? initialValue;

  FieldValue? get initialValueAsFieldValue => mapper.toFieldValue(initialValue);

  bool _enabled;

  final bool Function(Value x, Value y) areEqual;

  final Mapper<Value, FieldValue> mapper;

  FormFieldState<FieldValue>? _formFieldState;

  String? _forcedErrorText;

  FooFieldController({
    required this.areEqual,
    required bool? enabled,
    required String? forcedErrorText,
    required this.initialValue,
    required this.mapper,
  }) : _enabled = enabled ?? true,
       _forcedErrorText = forcedErrorText;

  void setFormFieldState(FormFieldState<FieldValue> formFieldState) {
    _formFieldState = formFieldState;
    value = initialValue;
    notifyListeners();
  }

  bool get enabled => _enabled;

  set enabled(bool value) {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        _enabled = value;
      },
    );
  }

  Value? get value {
    if (_formFieldState == null) {
      return initialValue;
    }
    return mapper.toValue(_formFieldState!.value);
  }

  set value(Value? newValue) {
    return excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        formFieldState.didChange(mapper.toFieldValue(newValue));
      },
    );
  }

  bool validate() {
    return excute<bool>(
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        return formFieldState.validate();
      },
    );
  }

  void clear() => value = null;

  void save() {
    return excute<void>(
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        formFieldState.save();
      },
    );
  }

  String? get forcedErrorText {
    return _forcedErrorText;
  }

  set forcedErrorText(String? value) {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        _forcedErrorText = value;
      },
    );
  }

  String? get errorText {
    if (_formFieldState == null) {
      return null;
    }
    return _formFieldState!.errorText;
  }

  bool get hasError {
    return excute<bool>(
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        return formFieldState.hasError;
      },
    );
  }

  bool get isValid {
    return excute<bool>(
      toExecute: (FormFieldState<FieldValue> formFieldState) {
        return formFieldState.isValid;
      },
    );
  }

  @protected
  R excute<R>({
    bool needToNotifyListener = false,
    required R Function(FormFieldState<FieldValue> formFieldState) toExecute,
  }) {
    _ensureStateExistence();
    R result = toExecute(_formFieldState!);
    if (needToNotifyListener) {
      notifyListeners();
    }
    return result;
  }

  void _ensureStateExistence() {
    if (_formFieldState == null) {
      throw Exception(
        "This Controller is not attached to a any Foo Form Field",
      );
    }
  }
}
