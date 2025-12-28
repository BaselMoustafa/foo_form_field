
import 'package:flutter/material.dart';

import '../../../core/models/range.dart';
import '../foo_form_field/foo_field_controller.dart';

class ConvertableRangeFieldController<
  Value, 
  FieldValue,
  BoundryController extends FooFieldController<Value, FieldValue>
> extends FooFieldController<Range<Value>, Range<FieldValue>> {
  
  final BoundryController minController;
  
  final BoundryController maxController;

  final bool Function(Value x, Value y) areEqualValues;

  ConvertableRangeFieldController({
    required super.mapper,
    required this.minController,
    required this.maxController,
    required this.areEqualValues,
    super.enabled,
    super.forcedErrorText,
  }) : super(
      areEqual: (Range<Value> x, Range<Value> y) => x == y,
      initialValue: Range<Value>(
      min: minController.value,
      max: maxController.value,
      areEqual: areEqualValues,
      )
    );

  @override
  /// Attaches the form field state and ensures sync listeners are wired.
  void setFormFieldState(FormFieldState<Range<FieldValue>> formFieldState) {
    super.setFormFieldState(formFieldState);
    _invokeSyncers();
  }

  @override
  /// Enables or disables both bound controllers along with the base controller.
  set enabled(bool value) {
    minController.enabled = value;
    maxController.enabled = value;
    super.enabled = value;
  }

  @override
  /// Saves the bounds first, then persists the overall range value.
  void save() {
    return excute(
      toExecute: (FormFieldState<Range<FieldValue?>> formFieldState) {
        minController.save();
        maxController.save();
        super.save();
      },
    );
  }

  @override
  /// Validates the bound controllers before validating the range itself.
  bool validate() {
    return excute<bool>(
      toExecute: (FormFieldState<Range<FieldValue?>> formFieldState) {
        bool isValidMin = minController.validate();
        bool isValidMax = maxController.validate();
        if (isValidMin && isValidMax) {
          return super.validate();
        }
        return false;
      },
    );
  }

  /// Hooks listeners that keep the range and bounds in sync.
  void _invokeSyncers() {
    addListener(_onRangeChanged);
    minController.addListener(_onMinValueChanged);
    maxController.addListener(_onMaxValueChanged);
  }

  /// Removes the synchronization listeners.
  void _removeSyncers() {
    removeListener(_onRangeChanged);
    minController.removeListener(_onMinValueChanged);
    maxController.removeListener(_onMaxValueChanged);
  }

  /// Updates the bound controllers when the range value changes.
  void _onRangeChanged() {
    if (value?.min != minController.value) {
      minController.value = value?.min;
    }
    if (value?.max != maxController.value) {
      maxController.value = value?.max;
    }
  }

  /// Reflects minimum bound changes back into the overall range value.
  void _onMinValueChanged() {
    if (value?.min == minController.value) {
      return;
    }
    value = Range<Value>(
      min: minController.value,
      max: value?.max,
      areEqual: areEqualValues,
    );
  }

  /// Reflects maximum bound changes back into the overall range value.
  void _onMaxValueChanged() {
    if (value?.max == maxController.value) {
      return;
    }
    value = Range<Value>(
      min: value?.min,
      max: maxController.value,
      areEqual: areEqualValues,
    );
  }

  @override
  /// Cleans up listeners and disposes the bound controllers.
  void dispose() {
    _removeSyncers();
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }
}
