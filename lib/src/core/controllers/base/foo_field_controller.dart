part of '../exporter.dart';

/// Generic field controller bridging UI field values (`I`) and client values (`O`).
///
/// `I` represents the raw value handled by `FormFieldState`, while `O` is what consumers expect.
class FooFieldController<O, I> extends ChangeNotifier {
  final O? initialValue;

  /// Maps the client initial value to the form-field representation.
  I? get initialValueAsFieldValue => mapper.toFieldType(initialValue);

  bool _enabled;

  final bool Function(O x, O y) areEqual;

  final FieldValueMapper<O, I> mapper;

  FormFieldState<I>? _formFieldState;

  String? _forcedErrorText;

  bool _isValueChanged;

  /// Tracks whether the last assignment changed the stored value.
  bool get isValueChanged => _isValueChanged;

  /// Configures the controller with equality, mapper, and optional defaults.
  FooFieldController({
    required this.areEqual,
    required bool? enabled,
    required String? forcedErrorText,
    required this.initialValue,
    required this.mapper,
  }) : _enabled = enabled ?? true,
       _forcedErrorText = forcedErrorText,
       _isValueChanged = false;

  static FooFieldController<O,I> fromRangeController<O,I>({
    required bool isMin,
    required ConvertableRangeFieldController<O,I> rangeController,
  }) {

    return FooFieldController<O,I>(
      forcedErrorText: null,
      areEqual: rangeController.areEqualValues,
      mapper: rangeController.valueMapper,
      initialValue: isMin ? rangeController.value?.min : rangeController.value?.max,
      enabled: rangeController.enabled,
    );
  }

  void setFormFieldState(FormFieldState<I> formFieldState) {
    _formFieldState = formFieldState;
    value = initialValue;
    notifyListeners();
  }

  /// Computes if two values should be considered different based on nullability/equality.
  bool _getIsValueChanged(O? x, O? y) {
    if (x == null && y == null) {
      return false;
    } else if (x == null && y != null) {
      return true;
    } else if (x != null && y == null) {
      return true;
    } else if (!areEqual(x as O, y as O)) {
      return true;
    }

    return false;
  }

  /// Current enabled state of the field.
  bool get enabled => _enabled;

  /// Updates the enabled state and notifies listeners.
  set enabled(bool value) {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<I> formFieldState) {
        _enabled = value;
      },
    );
  }

  /// Current value exposed to consumers (mapped from the form state).
  O? get value {
    if (_formFieldState == null) {
      return initialValue;
    }
    return mapper.toClientType(_formFieldState!.value);
  }

  /// Assigns a new value by updating the underlying form field state.
  set value(O? newValue) {
    return excute<void>(
      needToNotifyListener: true,
      isValueChanged: _getIsValueChanged(value, newValue),
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.didChange(mapper.toFieldType(newValue));
      },
    );
  }

  /// Validates the field, mutating the form state to reflect the result.
  bool validate() {
    return excute<bool>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.validate();
      },
    );
  }

  /// Resets the field value to `null`.
  void clear() => value = null;

  /// Triggers the form-field `onSaved` callback if provided.
  void save() {
    return excute<void>(
      toExecute: (FormFieldState<I> formFieldState) {
        formFieldState.save();
      },
    );
  }

  /// Explicit error text overriding validator output when set.
  String? get forcedErrorText {
    return _forcedErrorText;
  }

  /// Overrides current error text with a forced value and notifies listeners.
  set forcedErrorText(String? value) {
    excute<void>(
      needToNotifyListener: true,
      toExecute: (FormFieldState<I> formFieldState) {
        _forcedErrorText = value;
      },
    );
  }

  /// Current error message from the form state (if attached).
  String? get errorText {
    if (_formFieldState == null) {
      return null;
    }
    return _formFieldState!.errorText;
  }

  /// Indicates whether the field currently has an error without mutating state.
  bool get hasError {
    return excute<bool>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.hasError;
      },
    );
  }

  /// Indicates whether the field is valid without mutating state.
  bool get isValid {
    return excute<bool>(
      toExecute: (FormFieldState<I> formFieldState) {
        return formFieldState.isValid;
      },
    );
  }

  /// Executes logic requiring an attached `FormFieldState`, handling notifications.
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

  /// Ensures the controller is attached to a field before executing operations.
  void _ensureStateExistence() {
    if (_formFieldState == null) {
      throw Exception(
        "This Controller is not attached to a any Foo Form Field",
      );
    }
  }
}
