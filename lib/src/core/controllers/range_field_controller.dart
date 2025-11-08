

import 'package:flutter/widgets.dart';
import 'package:foo_form_field/foo_form_field.dart';

class ConvertableRangeFieldController<O,I> extends FooFieldController<Range<O>,Range<I>> {

  late final FooFieldController<O,I> minValueController;
  late final FooFieldController<O,I> maxValueController;

  ConvertableRangeFieldController({
    super.enabled,
    super.initialValue,
    super.forcedErrorText,
    required O? Function(I? i) fromFieldValue,
    required I? Function(O? o) toFieldValue,
  }):
    minValueController = FooFieldController<O,I>(
      initialValue: initialValue?.min,
      enabled: enabled,
      fromFieldValue: fromFieldValue,
      toFieldValue: toFieldValue,
      forcedErrorText: null,
    ), 
    maxValueController = FooFieldController<O,I>(
      initialValue: initialValue?.max,
      enabled: enabled,
      fromFieldValue: fromFieldValue,
      toFieldValue: toFieldValue,
      forcedErrorText: null,
    ),super(
      fromFieldValue: (Range<I>? inputRange){
        if (inputRange == null) {
          return null;
        }
        return Range<O>(
          min: fromFieldValue(inputRange.min),
          max: fromFieldValue(inputRange.max),
        );
      },
      toFieldValue: (Range<O>? outputRange){
        if (outputRange == null) {
          return null;
        }
        return Range<I>(
          min: toFieldValue(outputRange.min),
          max: toFieldValue(outputRange.max),
        );
      },
    );

  @override
  void setFormFieldState(FormFieldState<Range<I>> formFieldState) {
    _invokeSyncers();
    super.setFormFieldState(formFieldState);
  }

  @override
  set enabled(bool value) {
    minValueController.enabled = value;
    maxValueController.enabled = value;
    super.enabled = value;
  }

  @override
  void save() {
    return excute(
      toExecute: (FormFieldState<Range<I?>> formFieldState) {
        minValueController.save();
        maxValueController.save();
        super.save();
      },
    );
  }

  @override
  bool validate() {
    return excute<bool>(
      toExecute: (FormFieldState<Range<I?>> formFieldState) {
        bool isValidMin = minValueController.validate();
        bool isValidMax = maxValueController.validate();
        if (isValidMin && isValidMax) {
          return super.validate();
        }
        return false;
      },
    );
  }

  void _invokeSyncers(){
    addListener(_onRangeChanged);
    minValueController.addListener(_onMinValueChanged);
    maxValueController.addListener(_onMaxValueChanged);
  }
  void _removeSyncers(){
    removeListener(_onRangeChanged);
    minValueController.removeListener(_onMinValueChanged);
    maxValueController.removeListener(_onMaxValueChanged);
  }

  void _onRangeChanged(){
    if (value?.min!=minValueController.value) {
      minValueController.value = value?.min;
    }
    if (value?.max!=maxValueController.value) {
      maxValueController.value = value?.max;
    }
  }

  void _onMinValueChanged(){
    if (value?.min==minValueController.value) {
      return;
    }
    value = Range(
      min: minValueController.value, 
      max: value?.max,
    );
  }

  void _onMaxValueChanged(){
    if (value?.max==maxValueController.value) {
      return;
    }
    value = Range(
      min: value?.min, 
      max: maxValueController.value,
    );
  }

  @override
  void dispose() {
    _removeSyncers();
    minValueController.dispose();
    maxValueController.dispose();
    super.dispose();
  }
  
}

class RangeFieldController<T> extends ConvertableRangeFieldController<T,T> {
  RangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    fromFieldValue: (T? i) => i,
    toFieldValue: (T? o) => o,
  );
}
