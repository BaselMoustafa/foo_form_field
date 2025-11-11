import 'package:flutter/widgets.dart';
import 'package:foo_form_field/foo_form_field.dart';
import 'package:foo_form_field/src/core/mappers/base/field_value_mapper.dart';

class ConvertableRangeFieldController<O,I,B extends ConvertableRangeBoundryFieldController<O,I> > extends FooFieldController<Range<O>,Range<I>> {

  B? _minValueController;
  B? _maxValueController;

  B get minValueController{
    _minValueController ??= minBoundryControllerBuilder(this);
    return _minValueController!;
  }

  B get maxValueController{
    _maxValueController ??= maxBoundryControllerBuilder(this);
    return _maxValueController!;
  }

  final bool Function(O x, O y) areEqualValues;
  final FieldValueMapper<O,I> valueMapper;
  final B Function(ConvertableRangeFieldController<O,I,B> rangeFieldController) minBoundryControllerBuilder;
  final B Function(ConvertableRangeFieldController<O,I,B> rangeFieldController) maxBoundryControllerBuilder;

  ConvertableRangeFieldController({
    super.enabled,
    super.initialValue,
    super.forcedErrorText,
    required this.valueMapper,
    required this.areEqualValues,
    required this.minBoundryControllerBuilder,
    required this.maxBoundryControllerBuilder,
  }):super(
    mapper: valueMapper.toRangeMapper(areEqualOutputs: areEqualValues),
    areEqual: (Range<O> x, Range<O> y)=>x==y,
  );

  @override
  void setFormFieldState(FormFieldState<Range<I>> formFieldState) {
    super.setFormFieldState(formFieldState);
    _invokeSyncers();
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
    value = Range<O>(
      min: minValueController.value, 
      max: value?.max, 
      areEqual: areEqualValues,
    );
  }

  void _onMaxValueChanged(){
    if (value?.max==maxValueController.value) {
      return;
    }
    value = Range<O>(
      min: value?.min, 
      max: maxValueController.value, 
      areEqual: areEqualValues,
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