import 'package:flutter/widgets.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/mappers/base/field_value_mapper.dart';
import 'package:foo_form_field/src/core/ranges/range.dart';

class ConvertableRangeFieldController<O,I> extends FooFieldController<Range<O>,Range<I>> {

  late final FooFieldController<O,I> minValueController;
  late final FooFieldController<O,I> maxValueController;

  ConvertableRangeFieldController({
    super.enabled,
    super.initialValue,
    super.forcedErrorText,
    required bool Function(O x, O y) areEqual,
    required FieldValueMapper<O,I> valueMapper,
  }):
    minValueController = FooFieldController<O,I>(
      initialValue: initialValue?.min,
      enabled: enabled,
      mapper: valueMapper,
      forcedErrorText: null,
      areEqual: areEqual,
    ), 
    maxValueController = FooFieldController<O,I>(
      initialValue: initialValue?.max,
      enabled: enabled,
      mapper: valueMapper,
      forcedErrorText: null,
      areEqual: areEqual,
    ),super(
      mapper: valueMapper.toRangeMapper(areEqualOutputs: areEqual),
      areEqual: (Range<O> x, Range<O> y)=>x==y,
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
    final newRange = value?.copyWith(min: minValueController.value);
    value = newRange;
  }

  void _onMaxValueChanged(){
    if (value?.max==maxValueController.value) {
      return;
    }
    final newRange = value?.copyWith(max: maxValueController.value);
    value = newRange;
  }

  @override
  void dispose() {
    _removeSyncers();
    minValueController.dispose();
    maxValueController.dispose();
    super.dispose();
  }
  
}