import 'package:flutter/material.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/models/range.dart';

class ConvertableRangeFieldController<O, I> extends FooFieldController<Range<O?>, Range<I?>> {

  ConvertableRangeFieldController({
    super.enabled,
    super.initialValue,
    required super.fromFieldValue,
    required super.toFieldValue,
  });

  FormFieldState<I>? _minFormFieldState;
  FormFieldState<I>? _maxFormFieldState;

  void setFormFieldStates({
    required FormFieldState<I> minFormFieldState,
    required FormFieldState<I> maxFormFieldState,
  }){
    _minFormFieldState = minFormFieldState;
    _maxFormFieldState = maxFormFieldState;
  }

  set minValue(I? value) {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        minFormFieldState.didChange(value);
        notifyListeners();
      },
    );
  }

  set maxValue(I? value) {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        maxFormFieldState.didChange(value);
        notifyListeners();
      },
    );
  }

  I? get minValue=>_minFormFieldState?.value;
  
  I? get maxValue=>_maxFormFieldState?.value;

  @override
  set value(Range<O?>? value) {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        Range<I?>? fieldRange = toFieldValue(value);
        minFormFieldState.didChange(fieldRange?.min);
        maxFormFieldState.didChange(fieldRange?.max);
        notifyListeners();
      },
    );
  }

  @override
  Range<O?>? get value{
    if (_minFormFieldState == null || _maxFormFieldState == null) {
      return initialValue;
    }
    return fromFieldValue(
      Range<I?>(
        min: _minFormFieldState!.value,
        max: _maxFormFieldState!.value,
      ),
    );
  }

  @override
  void clear() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        minFormFieldState.didChange(null);
        maxFormFieldState.didChange(null);
        notifyListeners();
      },
    );
  }

  void clearMinValue() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        minFormFieldState.didChange(null);
        notifyListeners();
      },
    );
  }

  void clearMaxValue() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        maxFormFieldState.didChange(null);
        notifyListeners();
      },
    );
  }
  
  @override
  void save() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        minFormFieldState.save();
        maxFormFieldState.save();
        notifyListeners();
      },
    );
  }

  void saveMinValue() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        minFormFieldState.save();
        notifyListeners();
      },
    );
  }
  void saveMaxValue() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<void>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        maxFormFieldState.save();
        notifyListeners();
      },
    );
  }
  

  bool validateMinValue() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<bool>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        return minFormFieldState.validate();
      },
    );
  }

  bool validateMaxValue() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<bool>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        return maxFormFieldState.validate();
      },
    );
  }

  @override
  bool validate() {
    return _excuteAfterCheckMinAndMaxFormFieldStatesExistence<bool>(
      toExecute: (minFormFieldState, maxFormFieldState) {
        bool isValidMin = minFormFieldState.validate();
        bool isValidMax = maxFormFieldState.validate();
        return isValidMin && isValidMax;
      },
    );
  }

  R _excuteAfterCheckMinAndMaxFormFieldStatesExistence<R>({
    required R Function(FormFieldState<I> minFormFieldState, FormFieldState<I> maxFormFieldState) toExecute,
  }) {
    if (_minFormFieldState == null || _maxFormFieldState == null) {
      throw Exception(
        "Min or Max form field state is not set",
      );
    }
    return toExecute(_minFormFieldState!, _maxFormFieldState!);
  }
  
}

class RangeFieldController<T> extends ConvertableRangeFieldController<T, T> {

  RangeFieldController({
    super.enabled,
    super.initialValue,
  }): super(
    fromFieldValue: (i) => i,
    toFieldValue: (o) => o,
  );
}